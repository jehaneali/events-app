defmodule EventsApp.UsrsTest do
  use EventsApp.DataCase

  alias EventsApp.Usrs

  describe "usrs" do
    alias EventsApp.Usrs.Usr

    @valid_attrs %{email: "some email", name: "some name"}
    @update_attrs %{email: "some updated email", name: "some updated name"}
    @invalid_attrs %{email: nil, name: nil}

    def usr_fixture(attrs \\ %{}) do
      {:ok, usr} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Usrs.create_usr()

      usr
    end

    test "list_usrs/0 returns all usrs" do
      usr = usr_fixture()
      assert Usrs.list_usrs() == [usr]
    end

    test "get_usr!/1 returns the usr with given id" do
      usr = usr_fixture()
      assert Usrs.get_usr!(usr.id) == usr
    end

    test "create_usr/1 with valid data creates a usr" do
      assert {:ok, %Usr{} = usr} = Usrs.create_usr(@valid_attrs)
      assert usr.email == "some email"
      assert usr.name == "some name"
    end

    test "create_usr/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Usrs.create_usr(@invalid_attrs)
    end

    test "update_usr/2 with valid data updates the usr" do
      usr = usr_fixture()
      assert {:ok, %Usr{} = usr} = Usrs.update_usr(usr, @update_attrs)
      assert usr.email == "some updated email"
      assert usr.name == "some updated name"
    end

    test "update_usr/2 with invalid data returns error changeset" do
      usr = usr_fixture()
      assert {:error, %Ecto.Changeset{}} = Usrs.update_usr(usr, @invalid_attrs)
      assert usr == Usrs.get_usr!(usr.id)
    end

    test "delete_usr/1 deletes the usr" do
      usr = usr_fixture()
      assert {:ok, %Usr{}} = Usrs.delete_usr(usr)
      assert_raise Ecto.NoResultsError, fn -> Usrs.get_usr!(usr.id) end
    end

    test "change_usr/1 returns a usr changeset" do
      usr = usr_fixture()
      assert %Ecto.Changeset{} = Usrs.change_usr(usr)
    end
  end
end
