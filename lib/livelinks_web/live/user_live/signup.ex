defmodule LivelinksWeb.UserLive.Signup do
  use LivelinksWeb, :live_view

  alias Livelinks.Accounts
  alias Livelinks.Accounts.User
  alias Livelinks.Links.Link

  @impl true
  def mount(_params, _session, socket) do
    changeset = Livelinks.Accounts.User.changeset(%User{})
    changeset_link = Livelinks.Links.Link.changeset(%Link{})

    socket =
      assign(socket, %{
        changeset: changeset,
        changeset_link: changeset_link,
        username: "",
        password: "",
        links: []
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
    %{"username" => username, "password" => password} = user

    case Accounts.create_user(%{username: username, password: password}) do
      {:ok, _user} ->
        {:noreply, socket |> put_flash(:info, "user succesfully created")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
