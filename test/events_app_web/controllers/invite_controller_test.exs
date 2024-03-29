defmodule EventsAppWeb.InviteControllerTest do
  use EventsAppWeb.ConnCase

  alias EventsApp.Invites

  @create_attrs %{body: "some body"}
  @update_attrs %{body: "some updated body"}
  @invalid_attrs %{body: nil}

  def fixture(:invite) do
    {:ok, invite} = Invites.create_invite(@create_attrs)
    invite
  end

  describe "index" do
    test "lists all invite", %{conn: conn} do
      conn = get(conn, Routes.invite_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Invite"
    end
  end

  describe "new invite" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.invite_path(conn, :new))
      assert html_response(conn, 200) =~ "New Invite"
    end
  end

  describe "create invite" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.invite_path(conn, :create), invite: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.invite_path(conn, :show, id)

      conn = get(conn, Routes.invite_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Invite"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.invite_path(conn, :create), invite: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Invite"
    end
  end

  describe "edit invite" do
    setup [:create_invite]

    test "renders form for editing chosen invite", %{conn: conn, invite: invite} do
      conn = get(conn, Routes.invite_path(conn, :edit, invite))
      assert html_response(conn, 200) =~ "Edit Invite"
    end
  end

  describe "update invite" do
    setup [:create_invite]

    test "redirects when data is valid", %{conn: conn, invite: invite} do
      conn = put(conn, Routes.invite_path(conn, :update, invite), invite: @update_attrs)
      assert redirected_to(conn) == Routes.invite_path(conn, :show, invite)

      conn = get(conn, Routes.invite_path(conn, :show, invite))
      assert html_response(conn, 200) =~ "some updated body"
    end

    test "renders errors when data is invalid", %{conn: conn, invite: invite} do
      conn = put(conn, Routes.invite_path(conn, :update, invite), invite: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Invite"
    end
  end

  describe "delete invite" do
    setup [:create_invite]

    test "deletes chosen invite", %{conn: conn, invite: invite} do
      conn = delete(conn, Routes.invite_path(conn, :delete, invite))
      assert redirected_to(conn) == Routes.invite_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.invite_path(conn, :show, invite))
      end
    end
  end

  defp create_invite(_) do
    invite = fixture(:invite)
    %{invite: invite}
  end
end
