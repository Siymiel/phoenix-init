defmodule ShopWeb.ProductController do
  use ShopWeb, :controller

  # alias Shop.Repo
  alias Shop.Products

  # @products [
  #   %{
  #     id: "1",
  #     title: "The Legend of Zelda: Tears of the Kingdom",
  #     console: "nintendo",
  #     price: 69.99,
  #     image: "/images/zelda-totk.jpg"
  #   },
  #   %{
  #     id: "2",
  #     title: "God of War Ragnarök",
  #     console: "playstation",
  #     price: 59.99,
  #     image: "/images/god-of-war-ragnarok.jpg"
  #   },
  #   %{
  #     id: "3",
  #     title: "Elden Ring",
  #     console: "pc",
  #     price: 49.99,
  #     image: "/images/elden-ring.jpg"
  #   },
  #   %{
  #     id: "4",
  #     title: "Halo Infinite",
  #     console: "xbox",
  #     price: 39.99,
  #     image: "/images/halo-infinite.jpg"
  #   }
  # ]

  def index(conn, _params) do
    # products = Repo.all(Product)
    products = Products.list_products()
    conn
    |> assign(:products, products)
    |> render(:index)
  end

  def show(conn, %{"slug" => slug}) do
    # product = Enum.find(@products, fn product -> product.id == id end)
    # product = Repo.get_by(Product, slug: slug)
    product = Products.get_product_by_slug!(slug) # Recommended

    conn
    |> assign(:product, product)
    |> render(:show)
  end

  def delete(conn, %{"id" => id}) do
    product = Products.get_product!(id)
    {:ok, _product} = Products.delete_product(product)

    conn
    |> put_flash(:info, "Product deleted successfully.")
    # |> redirect(to: Routes.product_path(conn, :index))
  end
end
