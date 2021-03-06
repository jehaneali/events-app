defmodule EventsAppWeb.Plugs.FetchUsr do
  import Plug.Conn

  def init(args), do: args

  def call(conn, _args) do
    usr_id = get_session(conn, :usr_id) || -1
    usr = EventsApp.Usrs.get_usr(usr_id)
    if usr do
        assign(conn, :current_usr, usr)
    else
      assign(conn, :current_usr, nil)
    end
  end
end
