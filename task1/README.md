# Static vs Stack vs Heap Allocation

Three functions declare the same 100,000-int array: one `static`,
one on the stack, one on the heap with `new`. Each is called 100,000 
times and timed with `std::chrono::steady_clock`.

## Run (macOS)

```
g++ -O0 array_comparison.cpp -o array_comparison
./array_comparison
```

`-O0` turns off optimization.

## Results

```
Static: 0.558708 ms
Stack:  0.912416 ms
Heap:   22.1789 ms
```

## What each function does in memory

- **Static:** `static int data[...]` lives in the `.bss` segment,
a part of the program's memory reserved once when the program loads
and kept until it exits. The function reuses the same array on every
call, so there is no allocation cost. It was really interesting since
I have not seen equivalent in Java, since every array is an object on
the heap, and even a `static` field only holds a reference to it.
- **Stack:** the array is created on every call by moving the stack
pointer down and freed by moving it back on return. It's one instruction
each way, so it's only slightly slower than static.
- **Heap:** `new` asks the allocator and `delete[]` returns it on every call.
The allocator has to find a free block, which makes this slower than static.

## Why the functions touch the array

I made each function such that it writes `data[i % ARRAY_SIZE] = i`
and reads it back into `result`. An array that is never used would be
removed by the compiler, and the benchmark would not show the correct
results. `i % ARRAY_SIZE` keeps the index inside the array if `NUM_CALLS`
is ever raised above the array size.

## Why `volatile`

The compiler normally skips writes to a variable that is never read
afterwards. Marking `result` as `volatile` tells it the variable might
be read from somewhere it cannot see, so every write must really happen.
In our case `result` variable is not read anywhere in the program,
therefore there was a risk of compiler skipping writes to it.
Since each write uses a value from the array, the compiler has to keep
the array too, otherwise the whole function could be optimized into nothing.

## Generic timing function

I used one template function, `timeIt`, to time all three cases:

    template <typename Func>
    double timeIt(Func f)

`Func` can be any function type, so the same timing loop runs for
`staticAlloc`, `stackAlloc` and `heapAlloc`. This way all three are
measured in exactly the same way, and the only difference between them
is where the array is allocated. No need to make redundancy by writing
3 separate functions.