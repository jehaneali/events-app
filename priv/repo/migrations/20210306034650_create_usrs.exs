defmodule EventsApp.Repo.Migrations.CreateUsrs do
  use Ecto.Migration

  def change do
    create table(:usrs) do
      add :name, :string, null: false
      add :email, :string, null: false

      timestamps()
    end

  end
end
