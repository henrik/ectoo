defmodule EctooTest do
  use ExUnit.Case
  require Ecto.Query

  # Transactional tests: don't keep DB data.
  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Ectoo.Repo)
  end

  test ".count" do
    assert(
      (Ectoo.count(Ectoo.SomeModel) |> query_to_string)
      ==
      (Ecto.Query.from(x in Ectoo.SomeModel, select: count(x.id)) |> query_to_string)
    )
  end

  test ".count with custom primary key" do
    assert(
      (Ectoo.count(Ectoo.ModelWithFooPrimaryKey) |> query_to_string)
      ==
      (Ecto.Query.from(x in Ectoo.ModelWithFooPrimaryKey, select: count(x.foo)) |> query_to_string)
    )
  end

  test ".count with complex query" do
    query = Ecto.Query.from(x in Ectoo.SomeModel, where: x.id > 0)
    assert(
      (Ectoo.count(query) |> query_to_string)
      ==
      (Ecto.Query.from(x in query, select: count(x.id)) |> query_to_string)
    )
  end

  test ".count with repo" do
    create_model
    create_model

    assert (Ectoo.Repo |> Ectoo.count(Ectoo.SomeModel)) == 2
  end

  test ".max" do
    assert(
      (Ectoo.max(Ectoo.SomeModel, :id) |> query_to_string)
      ==
      (Ecto.Query.from(x in Ectoo.SomeModel, select: max(x.id)) |> query_to_string)
    )
  end

  # Let's test only one of these.
  test ".max with complex query" do
    query = Ecto.Query.from(x in Ectoo.SomeModel, where: x.id > 0)

    assert(
      (Ectoo.max(query, :id) |> query_to_string)
      ==
      (Ecto.Query.from(x in query, select: max(x.id)) |> query_to_string)
    )
  end

  test ".max with repo" do
    create_model age: 1
    create_model age: 42

    assert (Ectoo.Repo |> Ectoo.max(Ectoo.SomeModel, :age)) == 42
  end

  test ".min" do
    assert(
      (Ectoo.min(Ectoo.SomeModel, :id) |> query_to_string)
      ==
      (Ecto.Query.from(x in Ectoo.SomeModel, select: min(x.id)) |> query_to_string)
    )
  end

  test ".min with repo" do
    create_model age: 1
    create_model age: 42

    assert (Ectoo.Repo |> Ectoo.min(Ectoo.SomeModel, :age)) == 1
  end

  test ".avg" do
    assert(
      (Ectoo.avg(Ectoo.SomeModel, :id) |> query_to_string)
      ==
      (Ecto.Query.from(x in Ectoo.SomeModel, select: avg(x.id)) |> query_to_string)
    )
  end

  test ".avg with repo" do
    create_model age: 10
    create_model age: 20

    assert Decimal.equal? (Ectoo.Repo |> Ectoo.avg(Ectoo.SomeModel, :age)), Decimal.new(15)
  end

  test ".sum" do
    assert(
      (Ectoo.sum(Ectoo.SomeModel, :id) |> query_to_string)
      ==
      (Ecto.Query.from(x in Ectoo.SomeModel, select: sum(x.id)) |> query_to_string)
    )
  end

  test ".sum with repo" do
    create_model age: 10
    create_model age: 20

    assert (Ectoo.Repo |> Ectoo.sum(Ectoo.SomeModel, :age)) == 30
  end

  defp create_model(opts \\ %{}) do
    struct(Ectoo.SomeModel, opts) |> Ectoo.Repo.insert!
  end

  # Queries can't be compared as-is; we need to convert them to strings.
  defp query_to_string(query) do
    Inspect.Ecto.Query.to_string(query)
  end
end
