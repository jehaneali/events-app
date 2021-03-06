defmodule EventsAppWeb.SessionController do
  use EventsAppWeb, :controller

  def create(conn, %{"name" => name}) do
    usr = PhotoBlog.Usrs.get_usr_by_name(name)
    if usr do
      conn
      |> put_session(:usr_id, usr.id)
      |> put_flash(:info, "Hi again, #{usr.name}")
      |> redirect(to: Routes.page_path(conn, :index))
    else
      conn
      |> delete_session(:usr_id)
      |> put_flash(:error, "Unable to login")
      |> redirect(to: Routes.page_path(conn, :index))
    end
  end

  def delete(conn, _params) do
    conn
    |> delete_session(:usr_id)
    |> put_flash(:info, "You have logged out")
    |> redirect(to: Routes.page_path(conn, :index))

  end

end
