defmodule EctooTest do
  use ExUnit.Case
  require Ecto.Query

  test ".count" do
    assert(
      (Ectoo.count(Ectoo.Model) |> to_sql)
      ==
      (Ecto.Query.from(x in Ectoo.Model, select: count(x.id)) |> to_sql)
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
    query = Ecto.Query.from(x in Ectoo.Model, where: x.id > 0)
    assert(
      (Ectoo.count(query) |> to_sql)
      ==
      (Ecto.Query.from(x in query, select: count(x.id)) |> to_sql)
    )
  end

  test ".max" do
    assert(
      (Ectoo.max(Ectoo.Model, :id) |> to_sql)
      ==
      (Ecto.Query.from(x in Ectoo.Model, select: max(x.id)) |> to_sql)
    )
  end

  # Let's test only one of these.
  test ".max with complex query" do
    query = Ecto.Query.from(x in Ectoo.Model, where: x.id > 0)

    assert(
      (Ectoo.max(query, :id) |> to_sql)
      ==
      (Ecto.Query.from(x in query, select: max(x.id)) |> to_sql)
    )
  end

  test ".min" do
    assert(
      (Ectoo.min(Ectoo.Model, :id) |> to_sql)
      ==
      (Ecto.Query.from(x in Ectoo.Model, select: min(x.id)) |> to_sql)
    )
  end

  test ".avg" do
    assert(
      (Ectoo.avg(Ectoo.Model, :id) |> to_sql)
      ==
      (Ecto.Query.from(x in Ectoo.Model, select: avg(x.id)) |> to_sql)
    )
  end

  test ".sum" do
    assert(
      (Ectoo.sum(Ectoo.Model, :id) |> to_sql)
      ==
      (Ecto.Query.from(x in Ectoo.Model, select: sum(x.id)) |> to_sql)
    )
  end

  defp to_sql(query) do
    Ecto.Adapters.SQL.to_sql(:all, Ectoo.Repo, query)
  end
end
