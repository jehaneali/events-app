defmodule EventsApp.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :body, :text, null: false
      add :event_id, references(:events, on_delete: :nothing), null: false
      add :usr_id, references(:usrs, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:comments, [:event_id])
    create index(:comments, [:usr_id])
  end
end
