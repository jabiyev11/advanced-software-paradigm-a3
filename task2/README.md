# Static vs Dynamic Binding in C#

A `Payment` base class with two children, `CardPayment` and `CashPayment`,
showing how `virtual`, `override` and `new` decide which method runs.

## Run

I ran it on the online compiler [onlinegdb.com](https://www.onlinegdb.com/)
with the language set to C#. Paste `Program.cs` and click Run.

## Output

```
--- Dynamic binding (virtual + override) ---
Charging card
Charging card

--- Static binding (new on non-virtual) ---
Receipt: payment
Receipt: card payment

--- Static binding (new on virtual) ---
Processing generic payment
Accepting cash
```

## Keywords

- **`virtual`:** marks a parent method that children are allowed to replace.
- **`override`:** replaces a `virtual` method. The method is chosen at runtime
  by the real object, so `Payment p = new CardPayment(); p.Process();` runs
  `CardPayment`'s version. This is **dynamic binding**.
- **`new`:** adds a separate method with the same name instead of replacing
  the parent's. The method is chosen at compile time by the variable's declared
  type, so through a `Payment` variable the parent's version runs. This is
  **static binding**.

`CashPayment` uses `new` on a method that is `virtual` in the parent. I wanted
to show that `virtual` alone isn't enough: without `override` nothing gets
replaced, and the parent's version still runs through a `Payment` variable.

## Difference from Java

Previously I thought binding worked the same way in every language, because
I first learned it in Java. In Java every method is virtual by default (without virtual keyword),
so overriding always gives dynamic binding and `@Override` is only an optional
check. In C# methods are non-virtual by default, so I had to mark the method
`virtual` and use `override` to get the same behavior. Java also has no
equivalent of `new`: a method with the same signature in a child class always
overrides the parent's. The closest thing to static binding in Java is
`static` methods, which are hidden rather than overridden.