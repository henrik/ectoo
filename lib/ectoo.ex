defmodule Ectoo do
  require Ecto.Query

  def count(model) do
    # TODO: Handle composite primary keys.
    [pk] = model.__schema__(:primary_key)
    Ecto.Query.from(
      m in model, select: count(field(m, ^pk))
    )
  end

  def max(model, column) do
    Ecto.Query.from(
      m in model, select: max(field(m, ^column))
    )
  end

  def min(model, column) do
    Ecto.Query.from(
      m in model, select: min(field(m, ^column))
    )
  end

  def avg(model, column) do
    Ecto.Query.from(
      m in model, select: avg(field(m, ^column))
    )
  end

  def sum(model, column) do
    Ecto.Query.from(
      m in model, select: sum(field(m, ^column))
    )
  end
end
