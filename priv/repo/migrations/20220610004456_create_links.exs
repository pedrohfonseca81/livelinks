defmodule Livelinks.Repo.Migrations.CreateLinks do
  use Ecto.Migration

  def change do
    create table(:links) do
      add :name, :string
      add :uri, :string

      add :user_id, references(:users)

      timestamps()
    end
  end
end
