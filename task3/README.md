# Library Catalog in Ruby

A small library system with a `LibraryItem` base class, three item types
(`Book`, `DVD`, `CD`) and a `Library` class that stores and manages them.
Each class is in its own file.

## Run

```
ruby main.rb
```

`main.rb` loads the other files with `require_relative`, so it is the only
file I run.

## Output

```
Book: "Concepts of Programming Languages" (2015)
  Author: Robert Sebesta
  Genre:  Programming
DVD: "Inception" (2010)
  Director: Christopher Nolan
  Genre:    Science Fiction
CD: "A Day at the Races" (1976)
  Artist: Queen
  Genre:  Rock

Library has 3 item(s):
Book: "Concepts of Programming Languages" (2015)
  Author: Robert Sebesta
  Genre:  Programming
DVD: "Inception" (2010)
  Director: Christopher Nolan
  Genre:    Science Fiction
CD: "A Day at the Races" (1976)
  Artist: Queen
  Genre:  Rock

Removed "Inception"
Library has 2 item(s):
Book: "Concepts of Programming Languages" (2015)
  Author: Robert Sebesta
  Genre:  Programming
CD: "A Day at the Races" (1976)
  Artist: Queen
  Genre:  Rock
```

## OOP principles

- **Inheritance:** `Book`, `DVD` and `CD` inherit from `LibraryItem` with `<`
  and call `super` in `initialize`, so the common fields are set in one place.
  Each child adds `genre`, and `DVD`/`CD` add `director`/`artist`.
- **Encapsulation:** fields are read-only through `attr_reader`, `common_info`
  is `protected`, and the library's `@items` list can only be changed through
  `add_item` and `remove_item`. `add_item` also rejects anything that is not a
  `LibraryItem`.
- **Polymorphism:** `display_item(item)` just calls `item.display_info`
  without checking the type. Each class prints itself in its own way, so
  `display_all_items` works for any mix of items.

## Difference from Java

Ruby's syntax looked unusual to me at first, because it doesn't look like
any other language I've used (`def ... end`, `@` for fields, blocks like
`{ |item| ... }`, no parentheses or semicolons). But it was easy to get used
to. The OOP ideas are the same as in Java, just shorter. `initialize` is the
constructor, `@field` is like `this.field`, and `attr_reader` replaces
writing getters by hand. Every method behaves like an overridable method in
Java, so I did not need anything like C#'s `virtual`/`override` from Task 2.
Unlike Java, the file name does not have to match the class name, but the
convention is still `LibraryItem` in `library_item.rb`.