defmodule EventsAppWeb.Helpers do
  alias EventsApp.Usrs.Usr

  def current_usr_id(conn) do
    usr = conn.assigns[:current_usr]
    usr && usr.id
  end

  def have_current_usr?(conn) do
    conn.assigns[:current_usr] != nil
  end

  def current_usr_is?(conn, %Usr{} = usr) do
    current_usr_is?(conn, usr.id)
  end
end
