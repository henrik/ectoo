defmodule Ectoo do
  require Ecto.Query

  def count(model) do
    # TODO: Handle other primary keys
    Ecto.Query.from(
      m in model, select: count(m.id)
    )
  end
end
