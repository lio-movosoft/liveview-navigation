defmodule Test20.Stuffies.Stuffy do
  use Ecto.Schema
  import Ecto.Changeset

  schema "stuffies" do
    field :name, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(stuffy, attrs) do
    stuffy
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
