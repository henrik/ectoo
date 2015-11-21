defmodule EctooTest do
  use ExUnit.Case
  require Ecto.Query

  # Transactional tests: don't keep DB data.
  setup do
    Ecto.Adapters.SQL.begin_test_transaction(Ectoo.Repo)

    ExUnit.Callbacks.on_exit fn ->
      Ecto.Adapters.SQL.rollback_test_transaction(Ectoo.Repo)
    end
  end

  test ".count" do
    assert(
      (Ectoo.count(Ectoo.SomeModel) |> to_sql)
      ==
      (Ecto.Query.from(x in Ectoo.SomeModel, select: count(x.id)) |> to_sql)
    )
  end

  test ".count with custom primary key" do
    assert(
      (Ectoo.count(Ectoo.ModelWithFooPrimaryKey) |> to_sql)
      ==
      (Ecto.Query.from(x in Ectoo.ModelWithFooPrimaryKey, select: count(x.foo)) |> to_sql)
    )
  end

  test ".count with complex query" do
    query = Ecto.Query.from(x in Ectoo.SomeModel, where: x.id > 0)
    assert(
      (Ectoo.count(query) |> to_sql)
      ==
      (Ecto.Query.from(x in query, select: count(x.id)) |> to_sql)
    )
  end

  test ".count with repo" do
    create_model
    create_model

    assert (Ectoo.Repo |> Ectoo.count(Ectoo.SomeModel)) == 2
  end

  test ".max" do
    assert(
      (Ectoo.max(Ectoo.SomeModel, :id) |> to_sql)
      ==
      (Ecto.Query.from(x in Ectoo.SomeModel, select: max(x.id)) |> to_sql)
    )
  end

  # Let's test only one of these.
  test ".max with complex query" do
    query = Ecto.Query.from(x in Ectoo.SomeModel, where: x.id > 0)

    assert(
      (Ectoo.max(query, :id) |> to_sql)
      ==
      (Ecto.Query.from(x in query, select: max(x.id)) |> to_sql)
    )
  end

  test ".max with repo" do
    create_model age: 1
    create_model age: 42

    assert (Ectoo.Repo |> Ectoo.max(Ectoo.SomeModel, :age)) == 42
  end

  test ".min" do
    assert(
      (Ectoo.min(Ectoo.SomeModel, :id) |> to_sql)
      ==
      (Ecto.Query.from(x in Ectoo.SomeModel, select: min(x.id)) |> to_sql)
    )
  end

  test ".min with repo" do
    create_model age: 1
    create_model age: 42

    assert (Ectoo.Repo |> Ectoo.min(Ectoo.SomeModel, :age)) == 1
  end

  test ".avg" do
    assert(
      (Ectoo.avg(Ectoo.SomeModel, :id) |> to_sql)
      ==
      (Ecto.Query.from(x in Ectoo.SomeModel, select: avg(x.id)) |> to_sql)
    )
  end

  test ".avg with repo" do
    create_model age: 10
    create_model age: 20

    assert Decimal.equal? (Ectoo.Repo |> Ectoo.avg(Ectoo.SomeModel, :age)), Decimal.new(15)
  end

  test ".sum" do
    assert(
      (Ectoo.sum(Ectoo.SomeModel, :id) |> to_sql)
      ==
      (Ecto.Query.from(x in Ectoo.SomeModel, select: sum(x.id)) |> to_sql)
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

  defp to_sql(query) do
    Ecto.Adapters.SQL.to_sql(:all, Ectoo.Repo, query)
  end
end
