defmodule Ectoo.Model do
  use Ecto.Schema

  schema "models" do
  end
end

defmodule Ectoo.ModelWithFooPrimaryKey do
  use Ecto.Schema

  @primary_key {:foo, :string, []}
  schema "models2" do
  end
end
