defmodule EventsApp.Invites.Invite do
  use Ecto.Schema
  import Ecto.Changeset

  schema "invite" do
    field :body, :string
    field :email, :string
    belongs_to :event, EventsApp.Events.Event


    timestamps()
  end

  @doc false
  def changeset(invite, attrs) do
    invite
    |> cast(attrs, [:body, :email, :event_id])
    |> validate_required([:body, :email, :event_id])
  end
end
