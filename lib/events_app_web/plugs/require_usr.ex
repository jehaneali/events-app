defmodule EventsAppWeb.Plugs.RequireUsr do
  use EventsAppWeb, :controller

  def init(args), do: args

  def call(conn, _args) do
    if conn.assigns[:current_usr] do
      conn
    else
      conn
      |> put_flash(:error, "You need to log in to do this")
      |> redirect(to: Routes.page_path(conn, :index))
      |> halt()
    end

  end
end
