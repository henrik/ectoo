defmodule Ectoo do
  require Ecto.Query

  def count(query) do
    # COUNT("*") would also count NULL values:
    # http://stackoverflow.com/q/10863936/6962

    # TODO: Handle composite primary keys.

    pk = Ectoo.Utils.primary_key(query)

    Ecto.Query.from(
      m in query, select: count(field(m, ^pk))
    )
  end
  def count(repo, query), do: count(query) |> repo.one

  def max(model, column) do
    Ecto.Query.from(
      m in model, select: max(field(m, ^column))
    )
  end
  def max(repo, model, column), do: __MODULE__.max(model, column) |> repo.one

  def min(model, column) do
    Ecto.Query.from(
      m in model, select: min(field(m, ^column))
    )
  end
  def min(repo, model, column), do: __MODULE__.min(model, column) |> repo.one

  def avg(model, column) do
    Ecto.Query.from(
      m in model, select: avg(field(m, ^column))
    )
  end
  def avg(repo, model, column), do: avg(model, column) |> repo.one

  def sum(model, column) do
    Ecto.Query.from(
      m in model, select: sum(field(m, ^column))
    )
  end
  def sum(repo, model, column), do: sum(model, column) |> repo.one
end
