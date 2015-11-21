defmodule EctooTest do
  use ExUnit.Case
  require Ecto.Query

  test "count" do
    assert(
      (Ectoo.count(Ectoo.Model) |> to_sql)
      ==
      (Ecto.Query.from(x in Ectoo.Model, select: count(x.id)) |> to_sql)
    )
  end

  defp to_sql(query) do
    Ecto.Adapters.SQL.to_sql(:all, Ectoo.Repo, query)
  end
end
