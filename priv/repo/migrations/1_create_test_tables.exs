defmodule Ectoo.Repo.Migrations.CreateTestTables do
  use Ecto.Migration

  def change do
    create table(:some_models) do
      add :age, :integer
    end
  end
end
