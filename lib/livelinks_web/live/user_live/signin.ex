defmodule LivelinksWeb.UserLive.Signin do
  use LivelinksWeb, :live_view

  alias Livelinks.Accounts
  alias Livelinks.Accounts.User
  alias Livelinks.Links.Link

  @impl true
  def mount(_params, session, socket) do
    socket =
      socket
      |> PhoenixLiveSession.maybe_subscribe(session)

    IO.inspect(socket)

    changeset = Livelinks.Accounts.User.changeset(%User{})
    changeset_link = Livelinks.Links.Link.changeset(%Link{})

    socket =
      assign(socket, %{
        changeset: changeset,
        changeset_link: changeset_link,
        username: "",
        password: ""
      })

    {:ok, socket}
  end

  @impl true
  def handle_event("validate", %{"user" => user}, socket) do
    changeset = %User{} |> User.changeset(user) |> Map.put(:action, :insert)

    {:noreply, assign(socket, changeset: changeset)}
  end

  @impl true
  def handle_event("submit", %{"user" => user}, socket) do
    %{"password" => password, "username" => username} = user

    case validate_auth(username, password) do
      {:ok, _user} ->
        {:noreply, socket |> put_flash(:info, "Success")}

      {:error, _reason} ->
        {:noreply, socket |> put_flash(:error, "Invalid user")}
    end
  end

  defp validate_auth(username, password) do
    user = Accounts.get_user_by_username(username)

    Argon2.check_pass(user, password)
  end
end
