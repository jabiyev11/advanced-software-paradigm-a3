#include <chrono>
#include <iostream>

const int ARRAY_SIZE = 100000;
const int NUM_CALLS = 100000;

volatile int result;

void staticAlloc(int i) {
    static int data[ARRAY_SIZE];
    data[i % ARRAY_SIZE] = i;
    result = data[i % ARRAY_SIZE];
}

void stackAlloc(int i) {
    int data[ARRAY_SIZE];
    data[i % ARRAY_SIZE] = i;
    result = data[i % ARRAY_SIZE];
}

void heapAlloc(int i) {
    int* data = new int[ARRAY_SIZE];
    data[i % ARRAY_SIZE] = i;
    result = data[i % ARRAY_SIZE];
    delete[] data;
}

template <typename Func>
double timeIt(Func f) {
    auto start = std::chrono::steady_clock::now();
    for (int i = 0; i < NUM_CALLS; i++) f(i);
    auto end = std::chrono::steady_clock::now();
    return std::chrono::duration<double, std::milli>(end - start).count();
}

int main() {
    std::cout << "Static: " << timeIt(staticAlloc) << " ms\n";
    std::cout << "Stack:  " << timeIt(stackAlloc)  << " ms\n";
    std::cout << "Heap:   " << timeIt(heapAlloc)   << " ms\n";
}