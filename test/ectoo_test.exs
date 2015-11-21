defmodule EctooTest do
  use ExUnit.Case
  require Ecto.Query

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

  test ".min" do
    assert(
      (Ectoo.min(Ectoo.SomeModel, :id) |> to_sql)
      ==
      (Ecto.Query.from(x in Ectoo.SomeModel, select: min(x.id)) |> to_sql)
    )
  end

  test ".avg" do
    assert(
      (Ectoo.avg(Ectoo.SomeModel, :id) |> to_sql)
      ==
      (Ecto.Query.from(x in Ectoo.SomeModel, select: avg(x.id)) |> to_sql)
    )
  end

  test ".sum" do
    assert(
      (Ectoo.sum(Ectoo.SomeModel, :id) |> to_sql)
      ==
      (Ecto.Query.from(x in Ectoo.SomeModel, select: sum(x.id)) |> to_sql)
    )
  end

  defp to_sql(query) do
    Ecto.Adapters.SQL.to_sql(:all, Ectoo.Repo, query)
  end
end
