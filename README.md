# Ectoo

[![Build Status](https://secure.travis-ci.org/henrik/ectoo.svg?branch=master "Build Status")](https://travis-ci.org/henrik/ectoo)

[Ecto](https://github.com/elixir-lang/ecto) is powerful, but a relatively low-level abstraction in some respects. Not all simple things are easy to do.

(This was more true of Ecto 1 than it is of Ecto 2. See examples below.)

This library aims to remedy that by building some convenient abstractions on top of Ecto.

Counting all records with Ecto 1:

``` elixir
require Ecto.Query
MyRepo.one(Ecto.Query.from m in MyModel, select: count(m.id))
```

Counting all records with Ecto 2:

``` elixir
MyRepo.aggregate(MyModel, :count, :id)
```

Counting all records with Ectoo:

``` elixir
MyRepo |> Ectoo.count(MyModel)
```

Ectoo does not aim to replace Ecto. Use Ectoo when you have simple needs, and Ecto for the rest.

If you want a query that is not executed immediately, just skip the repo:

``` elixir
Ectoo.count(MyModel)
```

You can use a more complex query instead of `MyModel`:

``` elixir
query = Ecto.Query.from m in MyModel, where: id > 5
Ectoo.count(query)
```

Ectoo currently includes these functions:

``` elixir
Ectoo.count(MyModel)
Ectoo.max(MyModel, :age)
Ectoo.min(MyModel, :age)
Ectoo.avg(MyModel, :age)
Ectoo.sum(MyModel, :age)
```

Each of these can optionally take a repo as the first argument, to execute the query immediately.


## Installation

Add Ectoo to your list of dependencies in `mix.exs`:

``` elixir
def deps do
  [
    {:ectoo, "~> 0.2.0"},
  ]
end
```

Note that if you're using Ecto 1, you need Ectoo 0.0.4. Later versions of Ectoo are only tested against Ecto 2 and so may not work with Ecto 1.

Ensure Ectoo is started before your application:

``` elixir
def application do
  [applications: [
    :ectoo,
  ]]
end
```


## Development

You must have Postgres installed to run the tests. If the Postgres user does not share your username, you can set the `ECTOO_DB_USER` environment variable.

Install the deps:

    mix deps.get

Create the test DB:

    MIX_ENV=test mix test.setup

Run the tests:

    mix test

If you need to drop the test DB and set it up anew, do:

    MIX_ENV=test mix test.reset


## TODO

- [ ] Hex docs
- [ ] Handle composite primary keys?
- [ ] Moar?


## Credits and license

By Henrik Nyh 2015-11-21 under the MIT license.
