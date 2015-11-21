defmodule Ectoo.Utils do
  def primary_key(query) do
    [key] = model(query).__schema__(:primary_key)
    key
  end

  def model(%Ecto.Query{from: {_table_name, model_or_query}}) do
    model(model_or_query)
  end
  def model(model), do: model
end
