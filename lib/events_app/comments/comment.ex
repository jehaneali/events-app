defmodule EventsApp.Comments.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "comments" do
    field :body, :string
    belongs_to :event, EventsApp.Events.Event
    belongs_to :usr, EventsApp.Usrs.Usr

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:body, :event_id, :usr_id])
    |> validate_required([:body, :event_id, :usr_id])
  end
end
