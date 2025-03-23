defmodule Test20Web.StuffyLiveTest do
  use Test20Web.ConnCase

  import Phoenix.LiveViewTest
  import Test20.StuffiesFixtures

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  defp create_stuffy(_) do
    stuffy = stuffy_fixture()
    %{stuffy: stuffy}
  end

  describe "Index" do
    setup [:create_stuffy]

    test "lists all stuffies", %{conn: conn, stuffy: stuffy} do
      {:ok, _index_live, html} = live(conn, ~p"/stuffies")

      assert html =~ "Listing Stuffies"
      assert html =~ stuffy.name
    end

    test "saves new stuffy", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/stuffies")

      assert index_live |> element("a", "New Stuffy") |> render_click() =~
               "New Stuffy"

      assert_patch(index_live, ~p"/stuffies/new")

      assert index_live
             |> form("#stuffy-form", stuffy: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#stuffy-form", stuffy: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/stuffies")

      html = render(index_live)
      assert html =~ "Stuffy created successfully"
      assert html =~ "some name"
    end

    test "updates stuffy in listing", %{conn: conn, stuffy: stuffy} do
      {:ok, index_live, _html} = live(conn, ~p"/stuffies")

      assert index_live |> element("#stuffies-#{stuffy.id} a", "Edit") |> render_click() =~
               "Edit Stuffy"

      assert_patch(index_live, ~p"/stuffies/#{stuffy}/edit")

      assert index_live
             |> form("#stuffy-form", stuffy: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#stuffy-form", stuffy: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/stuffies")

      html = render(index_live)
      assert html =~ "Stuffy updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes stuffy in listing", %{conn: conn, stuffy: stuffy} do
      {:ok, index_live, _html} = live(conn, ~p"/stuffies")

      assert index_live |> element("#stuffies-#{stuffy.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#stuffies-#{stuffy.id}")
    end
  end

  describe "Show" do
    setup [:create_stuffy]

    test "displays stuffy", %{conn: conn, stuffy: stuffy} do
      {:ok, _show_live, html} = live(conn, ~p"/stuffies/#{stuffy}")

      assert html =~ "Show Stuffy"
      assert html =~ stuffy.name
    end

    test "updates stuffy within modal", %{conn: conn, stuffy: stuffy} do
      {:ok, show_live, _html} = live(conn, ~p"/stuffies/#{stuffy}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Stuffy"

      assert_patch(show_live, ~p"/stuffies/#{stuffy}/show/edit")

      assert show_live
             |> form("#stuffy-form", stuffy: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#stuffy-form", stuffy: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/stuffies/#{stuffy}")

      html = render(show_live)
      assert html =~ "Stuffy updated successfully"
      assert html =~ "some updated name"
    end
  end
end
