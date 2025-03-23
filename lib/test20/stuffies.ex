defmodule Test20.Stuffies do
  @moduledoc """
  The Stuffies context.
  """

  import Ecto.Query, warn: false
  alias Test20.Repo

  alias Test20.Stuffies.Stuffy

  @doc """
  Returns the list of stuffies.

  ## Examples

      iex> list_stuffies()
      [%Stuffy{}, ...]

  """
  def list_stuffies do
    Repo.all(Stuffy)
  end

  @doc """
  Gets a single stuffy.

  Raises `Ecto.NoResultsError` if the Stuffy does not exist.

  ## Examples

      iex> get_stuffy!(123)
      %Stuffy{}

      iex> get_stuffy!(456)
      ** (Ecto.NoResultsError)

  """
  def get_stuffy!(id), do: Repo.get!(Stuffy, id)

  @doc """
  Creates a stuffy.

  ## Examples

      iex> create_stuffy(%{field: value})
      {:ok, %Stuffy{}}

      iex> create_stuffy(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_stuffy(attrs \\ %{}) do
    %Stuffy{}
    |> Stuffy.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a stuffy.

  ## Examples

      iex> update_stuffy(stuffy, %{field: new_value})
      {:ok, %Stuffy{}}

      iex> update_stuffy(stuffy, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_stuffy(%Stuffy{} = stuffy, attrs) do
    stuffy
    |> Stuffy.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a stuffy.

  ## Examples

      iex> delete_stuffy(stuffy)
      {:ok, %Stuffy{}}

      iex> delete_stuffy(stuffy)
      {:error, %Ecto.Changeset{}}

  """
  def delete_stuffy(%Stuffy{} = stuffy) do
    Repo.delete(stuffy)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking stuffy changes.

  ## Examples

      iex> change_stuffy(stuffy)
      %Ecto.Changeset{data: %Stuffy{}}

  """
  def change_stuffy(%Stuffy{} = stuffy, attrs \\ %{}) do
    Stuffy.changeset(stuffy, attrs)
  end
end
