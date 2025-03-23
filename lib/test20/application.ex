defmodule Test20.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Test20Web.Telemetry,
      Test20.Repo,
      {DNSCluster, query: Application.get_env(:test20, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Test20.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Test20.Finch},
      # Start a worker by calling: Test20.Worker.start_link(arg)
      # {Test20.Worker, arg},
      # Start to serve requests, typically the last entry
      Test20Web.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Test20.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    Test20Web.Endpoint.config_change(changed, removed)
    :ok
  end
end
