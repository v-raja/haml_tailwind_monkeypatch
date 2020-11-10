A monkeypatch for HAML to make it easier to write Tailwind CSS.

## How it works

Instead of writing:
``` haml
%div{class: "ab cd ef sm:gh sm: ij focus:kl focus:mn hover:op md:pq..."}
```
You can write:
``` haml
%div{class: "ab cd ef",
     sm:    "gh ij",
     md:    "pq",
     focus: "kl mn",
     hover: "op"}
```

Since the `class` attribute is repeated mulitple times, the monkeypatch also include a `c` attribute as an abbreviated form:
``` haml
%div{c: "ab cd"}
```
is the same as
``` haml
%div(class: "ab cd"}
```

## How to use it

Paste the monkeypatch in `app/helpers/application_helper.rb` after your `ApplicationHelper` module code.

## Note

This patch has only been test for HAML 5.1.2. If you're using this with a newer version of HAML, I'd suggest you have a look at the 
[original parse function](https://github.com/haml/haml/blob/c67e67274353526d5a5da2a8d36cabcc313ed7ab/lib/haml/attribute_parser.rb#L27) 
and change the monkeypatch as necessary (make a pull request while you're at it!).
