defmodule Shop.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :title, :string
      add :price, :float
      add :console, :string
      add :slug, :string

      timestamps(type: :utc_datetime)
    end

    create unique_index(:products, [:slug])
  end
end
