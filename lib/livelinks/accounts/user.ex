defmodule Livelinks.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Livelinks.Repo

  schema "users" do
    field :password, :string
    field :username, :string

    has_many :links, Livelinks.Links.Link

    timestamps()
  end

  @doc false
  def changeset(user, attrs \\ %{}) do
    user
    |> cast(attrs, [:username, :password])
    |> validate_required([:username, :password])
    |> unique_constraint(:username)
    |> unsafe_validate_unique(:username, Repo)
  end
end
