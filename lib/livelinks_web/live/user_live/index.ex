defmodule LivelinksWeb.UserLive.Index do
  use LivelinksWeb, :live_view

  alias Livelinks.Accounts.User

  @impl true
  def mount(%{"username" => username}, _session, socket) do
    socket = assign(socket, :username, username)

    case check_user(username) do
      %User{} = user ->
        user = Livelinks.Repo.preload(user, [:links])

        socket = assign(socket, %{user: user, links: user.links})
        {:ok, socket}

      nil ->
        socket = assign(socket, %{code: "404", reason: "the user #{username} does not exists."})

        {:ok, socket, layout: {LivelinksWeb.LayoutView, "error.html"}}
    end
  end

  defp check_user(username) do
    Livelinks.Accounts.get_user_by_username(username)
  end
end
