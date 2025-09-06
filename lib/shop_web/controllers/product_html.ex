defmodule ShopWeb.ProductHTML do
  @moduledoc """
  This module contains pages rendered by ProductController.

  See the `product_html` directory for all templates available.
  """
  use ShopWeb, :html

  embed_templates "product_html/*"
end
