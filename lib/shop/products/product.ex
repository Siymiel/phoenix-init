defmodule Shop.Products.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :title, :string
    field :price, :float
    field :console, Ecto.Enum, values: [:nintendo, :playstation, :pc, :xbox]
    field :slug, :string

    timestamps(type: :utc_datetime)
  end

  # Runs before we interact with the database

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:title, :price, :console])
    |> validate_required([:title, :price, :console])
    |> validate_length(:title, min: 3, max: 100)
    |> format_title()
    |> generate_slug()
    |> unique_constraint(:slug)
  end

  defp format_title(changeset) do
    title =
      changeset.changes.title
      |> String.trim()

      put_change(changeset, :title, title)
  end

  defp generate_slug(changeset) do
    if title = changeset.changes[:title] do
      slug =
        title
        |> String.downcase()
        |> String.replace(~r/[^\w-]+/u, "-")
        |> String.replace(~r/^-+|-+$/u, "")

      put_change(changeset, :slug, slug)
    else
      changeset
    end
  end
end
