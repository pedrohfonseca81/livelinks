defmodule Livelinks.Repo do
  use Ecto.Repo,
    otp_app: :livelinks,
    adapter: Ecto.Adapters.Postgres
end
