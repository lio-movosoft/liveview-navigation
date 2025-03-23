defmodule Test20.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Test20.Accounts` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Test20.Accounts.create_user()

    user
  end
end
