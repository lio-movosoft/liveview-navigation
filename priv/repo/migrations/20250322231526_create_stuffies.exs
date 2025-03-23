defmodule Test20.Repo.Migrations.CreateStuffies do
  use Ecto.Migration

  def change do
    create table(:stuffies) do
      add :name, :string

      timestamps(type: :utc_datetime)
    end
  end
end
