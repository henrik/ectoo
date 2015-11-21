# Ectoo

[Ecto](https://github.com/elixir-lang/ecto) is powerful, but a relatively low-level abstraction in some respects. Not all simple things are easy to do.

This library aims to remedy that by building some convenient abstractions on top of Ecto.

Counting all records with Ecto:

``` elixir
require Ecto.Query
Ecto.Query.from m in MyModel, select: count(m.id)
```

Counting all records with Ectoo:

``` elixir
Ectoo.count(MyModel)
```

Ectoo does not aim to replace Ecto. Use Ectoo when you have simple needs, and Ecto for the rest.

Ectoo currently lets you do:

``` elixir
Ectoo.count(MyModel)
Ectoo.max(MyModel, :age)
Ectoo.min(MyModel, :age)
Ectoo.avg(MyModel, :age)
Ectoo.sum(MyModel, :age)
```

You can use a more complex query instead of `MyModel`:

``` elixir
query = Ecto.Query.from m in MyModel, where: id > 5
Ectoo.count(query)
```


## Installation

Add Ectoo to your list of dependencies in `mix.exs`:

``` elixir
def deps do
  [
    {:ectoo, "> 0.0.0"},
  ]
end
```

Ensure Ectoo is started before your application:

``` elixir
def application do
  [applications: [
    :ectoo,
  ]]
end
```


## Development

    mix deps.get
    mix test


## TODO

- [ ] Hex docs
- [ ] Handle composite primary keys?
- [ ] Moar?


## Credits and license

By Henrik Nyh 2015-11-21 under the MIT license.
