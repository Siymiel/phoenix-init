defmodule ShopWeb.Plugs.SetConsole do
  # Import helper functions for working with connections (Plug.Conn struct).
  import Plug.Conn

  # List of valid console values that we allow.
  @valid_consoles ["pc", "xbox", "playstation", "nintendo"]

  # The `init/1` function is required by plugs.
  # It runs once when the plug is initialized and passes its value to `call/2`.
  # Here we just return the default console value.
  def init(default_console), do: default_console

  # CASE 1: If the request contains a "console" query parameter (e.g. ?console=pc),
  # AND its value is one of the valid consoles,
  # then:
  #   - Save it into conn.assigns (so we can use it later in controllers/views).
  #   - Store it as a cookie (so it persists in the browser for 30 days).
  def call(%Plug.Conn{:params => %{"console" => console}} = conn, _default_console)
      when console in @valid_consoles do
    conn
    |> assign(:console, console)
    |> put_resp_cookie("console", console, max_age: :timer.hours(24) * 30)
  end

  # CASE 2: If the request does NOT have a "console" param,
  # but the browser already has a "console" cookie,
  # AND its value is valid,
  # then just assign it to conn.assigns (no need to reset the cookie).
  def call(%Plug.Conn{:cookies => %{"console" => console}} = conn, _default_console)
      when console in @valid_consoles do
    conn
    |> assign(:console, console)
  end

  # CASE 3: If there’s no "console" param AND no valid "console" cookie,
  # then fall back to the default console that was passed into init/1.
  # We assign this default value and also set it as a cookie for persistence.
  def call(%Plug.Conn{} = conn, default_console) do
    conn
    |> assign(:console, default_console)
    |> put_resp_cookie("console", default_console, max_age: :timer.hours(24) * 30)
  end
end
