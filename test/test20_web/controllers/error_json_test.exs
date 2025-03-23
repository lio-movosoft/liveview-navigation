defmodule Test20Web.ErrorJSONTest do
  use Test20Web.ConnCase, async: true

  test "renders 404" do
    assert Test20Web.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert Test20Web.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
