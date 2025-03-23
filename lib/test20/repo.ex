defmodule Test20.Repo do
  use Ecto.Repo,
    otp_app: :test20,
    adapter: Ecto.Adapters.Postgres
end
