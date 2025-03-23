defmodule Test20.StuffiesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Test20.Stuffies` context.
  """

  @doc """
  Generate a stuffy.
  """
  def stuffy_fixture(attrs \\ %{}) do
    {:ok, stuffy} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Test20.Stuffies.create_stuffy()

    stuffy
  end
end
