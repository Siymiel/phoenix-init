defmodule ShopWeb.ProductController do
  use ShopWeb, :controller

  @products [
    %{
      id: "1",
      title: "The Legend of Zelda: Tears of the Kingdom",
      console: "nintendo",
      price: 69.99,
      image: "/images/zelda-totk.jpg"
    },
    %{
      id: "2",
      title: "God of War Ragnarök",
      console: "playstation",
      price: 59.99,
      image: "/images/god-of-war-ragnarok.jpg"
    },
    %{
      id: "3",
      title: "Elden Ring",
      console: "pc",
      price: 49.99,
      image: "/images/elden-ring.jpg"
    },
    %{
      id: "4",
      title: "Halo Infinite",
      console: "xbox",
      price: 39.99,
      image: "/images/halo-infinite.jpg"
    }
  ]

  def index(conn, _params) do
    conn
    |> assign(:products, @products)
    |> render(:index)
  end

  def show(conn, %{"id" => id}) do
    product = Enum.find(@products, fn product -> product.id == id end)

    conn
    |> assign(:product, product)
    |> render(:show)
  end
end
