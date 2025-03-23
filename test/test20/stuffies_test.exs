defmodule Test20.StuffiesTest do
  use Test20.DataCase

  alias Test20.Stuffies

  describe "stuffies" do
    alias Test20.Stuffies.Stuffy

    import Test20.StuffiesFixtures

    @invalid_attrs %{name: nil}

    test "list_stuffies/0 returns all stuffies" do
      stuffy = stuffy_fixture()
      assert Stuffies.list_stuffies() == [stuffy]
    end

    test "get_stuffy!/1 returns the stuffy with given id" do
      stuffy = stuffy_fixture()
      assert Stuffies.get_stuffy!(stuffy.id) == stuffy
    end

    test "create_stuffy/1 with valid data creates a stuffy" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Stuffy{} = stuffy} = Stuffies.create_stuffy(valid_attrs)
      assert stuffy.name == "some name"
    end

    test "create_stuffy/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Stuffies.create_stuffy(@invalid_attrs)
    end

    test "update_stuffy/2 with valid data updates the stuffy" do
      stuffy = stuffy_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Stuffy{} = stuffy} = Stuffies.update_stuffy(stuffy, update_attrs)
      assert stuffy.name == "some updated name"
    end

    test "update_stuffy/2 with invalid data returns error changeset" do
      stuffy = stuffy_fixture()
      assert {:error, %Ecto.Changeset{}} = Stuffies.update_stuffy(stuffy, @invalid_attrs)
      assert stuffy == Stuffies.get_stuffy!(stuffy.id)
    end

    test "delete_stuffy/1 deletes the stuffy" do
      stuffy = stuffy_fixture()
      assert {:ok, %Stuffy{}} = Stuffies.delete_stuffy(stuffy)
      assert_raise Ecto.NoResultsError, fn -> Stuffies.get_stuffy!(stuffy.id) end
    end

    test "change_stuffy/1 returns a stuffy changeset" do
      stuffy = stuffy_fixture()
      assert %Ecto.Changeset{} = Stuffies.change_stuffy(stuffy)
    end
  end
end
