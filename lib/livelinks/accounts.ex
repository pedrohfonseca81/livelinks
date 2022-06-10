defmodule Livelinks.Accounts do
  import Ecto.Query, warn: false

  alias Livelinks.Repo
  alias Livelinks.Accounts.User
  alias Ecto.Changeset

  def list_users do
    Repo.all(User)
  end

  def get_user!(id), do: Repo.get!(User, id)

  def get_user_by_username(username) do
    Repo.one(
      from u0 in Livelinks.Accounts.User,
        where: u0.username == ^username,
        select: u0
    )
  end

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  def put_link_assoc(%User{} = user, attrs) do
    link = Ecto.build_assoc(user, :links, attrs)

    Repo.insert!(link)
  end

  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end
end
