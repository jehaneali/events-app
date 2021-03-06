defmodule EventsAppWeb.UsrControllerTest do
  use EventsAppWeb.ConnCase

  alias EventsApp.Usrs

  @create_attrs %{email: "some email", name: "some name"}
  @update_attrs %{email: "some updated email", name: "some updated name"}
  @invalid_attrs %{email: nil, name: nil}

  def fixture(:usr) do
    {:ok, usr} = Usrs.create_usr(@create_attrs)
    usr
  end

  describe "index" do
    test "lists all usrs", %{conn: conn} do
      conn = get(conn, Routes.usr_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Usrs"
    end
  end

  describe "new user" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.usr_path(conn, :new))
      assert html_response(conn, 200) =~ "New Usr"
    end
  end

  describe "create user" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.usr_path(conn, :create), usr: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.usr_path(conn, :show, id)

      conn = get(conn, Routes.usr_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Usr"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.usr_path(conn, :create), usr: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Usr"
    end
  end

  describe "edit usr" do
    setup [:create_usr]

    test "renders form for editing chosen usr", %{conn: conn, usr: usr} do
      conn = get(conn, Routes.usr_path(conn, :edit, usr))
      assert html_response(conn, 200) =~ "Edit Usr"
    end
  end

  describe "update usr" do
    setup [:create_usr]

    test "redirects when data is valid", %{conn: conn, usr: usr} do
      conn = put(conn, Routes.usr_path(conn, :update, usr), usr: @update_attrs)
      assert redirected_to(conn) == Routes.usr_path(conn, :show, usr)

      conn = get(conn, Routes.usr_path(conn, :show, usr))
      assert html_response(conn, 200) =~ "some updated email"
    end

    test "renders errors when data is invalid", %{conn: conn, usr: usr} do
      conn = put(conn, Routes.usr_path(conn, :update, usr), usr: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Usr"
    end
  end

  describe "delete usr" do
    setup [:create_usr]

    test "deletes chosen usr", %{conn: conn, usr: usr} do
      conn = delete(conn, Routes.usr_path(conn, :delete, usr))
      assert redirected_to(conn) == Routes.usr_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.usr_path(conn, :show, usr))
      end
    end
  end

  defp create_usr(_) do
    usr = fixture(:usr)
    %{usr: usr}
  end
end
