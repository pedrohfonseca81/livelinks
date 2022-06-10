defmodule Livelinks.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Livelinks.Repo,
      # Start the Telemetry supervisor
      LivelinksWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Livelinks.PubSub},
      # Start the Endpoint (http/https)
      LivelinksWeb.Endpoint
      # Start a worker by calling: Livelinks.Worker.start_link(arg)
      # {Livelinks.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Livelinks.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LivelinksWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
