defmodule EventsApp.Repo.Migrations.CreateInvite do
  use Ecto.Migration

  def change do
    create table(:invite) do
      add :body, :string, null: false
      add :email, :string, null: false
      add :event_id, references(:events, on_delete: :nothing), null: false


      timestamps()
    end

    create index(:invite, [:event_id])
    # create index(:invite, [:email])
  end
end
