defmodule Livelinks.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Argon2
  alias Livelinks.Repo

  schema "users" do
    field :password, :string, virtual: true
    field :password_hash, :string
    field :username, :string

    has_many :links, Livelinks.Links.Link

    timestamps()
  end

  @doc false
  def changeset(user, attrs \\ %{}) do
    user
    |> cast(attrs, [:username, :password])
    |> validate_required([:username, :password])
    |> put_pass_hash()
    |> unique_constraint(:username)
    |> unsafe_validate_unique(:username, Repo)
  end

  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Argon2.add_hash(password))
  end

  defp put_pass_hash(changeset), do: changeset
end
