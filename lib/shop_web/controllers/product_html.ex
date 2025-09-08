defmodule ShopWeb.ProductHTML do
  @moduledoc """
  This module contains pages rendered by ProductController.

  See the `product_html` directory for all templates available.
  """
  use ShopWeb, :html

  embed_templates "product_html/*"

  # Function component to display individual product details
  attr :title, :string, required: true
  attr :price, :float, required: true
  attr :console, :string, required: true

  def product(assigns) do
    ~H"""
    <div>
      <p>Title: {@title}</p>
      <p>Price: ${@price}</p>
      <p>Console: {@console}</p>
    </div>
    """
  end
end
