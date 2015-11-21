defmodule Ectoo.SomeModel do
  use Ecto.Schema

  schema "some_models" do
  end
end

defmodule Ectoo.ModelWithFooPrimaryKey do
  use Ecto.Schema

  @primary_key {:foo, :string, []}
  schema "models2" do
  end
end
