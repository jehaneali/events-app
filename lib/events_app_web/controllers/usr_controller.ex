defmodule EventsAppWeb.UsrController do
  use EventsAppWeb, :controller

  alias EventsApp.Usrs
  alias EventsApp.Usrs.Usr

  def index(conn, _params) do
    usrs = Usrs.list_usrs()
    render(conn, "index.html", usrs: usrs)
  end

  def new(conn, _params) do
    changeset = Usrs.change_usr(%Usr{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"usr" => usr_params}) do
    case Usrs.create_usr(usr_params) do
      {:ok, usr} ->
        conn
        |> put_flash(:info, "Usr created successfully.")
        |> redirect(to: Routes.usr_path(conn, :show, usr))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    usr = Usrs.get_usr!(id)
    render(conn, "show.html", usr: usr)
  end

  def edit(conn, %{"id" => id}) do
    usr = Usrs.get_usr!(id)
    changeset = Usrs.change_usr(usr)
    render(conn, "edit.html", usr: usr, changeset: changeset)
  end

  def update(conn, %{"id" => id, "usr" => usr_params}) do
    usr = Usrs.get_usr!(id)

    case Usrs.update_usr(usr, usr_params) do
      {:ok, usr} ->
        conn
        |> put_flash(:info, "Usr updated successfully.")
        |> redirect(to: Routes.usr_path(conn, :show, usr))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", usr: usr, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    usr = Usrs.get_usr!(id)
    {:ok, _usr} = Usrs.delete_usr(usr)

    conn
    |> put_flash(:info, "Usr deleted successfully.")
    |> redirect(to: Routes.usr_path(conn, :index))
  end
end
