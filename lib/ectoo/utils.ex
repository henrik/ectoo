defmodule Ectoo.Utils do
  def primary_key(query) do
    [key] = model(query).__schema__(:primary_key)
    key
  end

  def model(%Ecto.Query{from: {"models", model_or_query}}), do: model(model_or_query)
  def model(model), do: model
end
