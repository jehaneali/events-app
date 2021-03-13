defmodule EventsAppWeb.UsrController do
  use EventsAppWeb, :controller

  alias EventsApp.Usrs
  alias EventsApp.Usrs.Usr
  alias EventsApp.Photos
  alias EventsAppWeb.Plugs

  plug Plugs.RequireUsr when action not in [:index, :show, :new, :create]

  def index(conn, _params) do
    usrs = Usrs.list_usrs()
    render(conn, "index.html", usrs: usrs)
  end

  def new(conn, _params) do
    changeset = Usrs.change_usr(%Usr{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"usr" => usr_params}) do
    up = usr_params["photo"]
    {:ok, hash} = Photos.save_photo(up.filename, up.path)
    usr_params = usr_params
    # |> Map.put("user_id", conn.assigns[:current_user].id)
    |> Map.put("photo_hash", hash)
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

  def photo(conn, %{"id" => id}) do
    usr = Usrs.get_usr!(id)
    {:ok, _name, data} = Photos.load_photo(usr.photo_hash)
    conn
    |> put_resp_content_type("image/jpeg")
    |> send_resp(200, data)
  end

  def edit(conn, %{"id" => id}) do
    usr = Usrs.get_usr!(id)
    changeset = Usrs.change_usr(usr)
    render(conn, "edit.html", usr: usr, changeset: changeset)
  end

  def update(conn, %{"id" => id, "usr" => usr_params}) do
    usr = Usrs.get_usr!(id)
    up = usr_params["photo"]

    usr_params = if up do
      {:ok, hash} = Photos.save_photo(up.filename, up.path)
      Map.put(usr_params, "photo_hash", hash)
    else
      usr_params
    end

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
