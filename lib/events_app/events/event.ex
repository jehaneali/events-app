defmodule EventsApp.Events.Event do
  use Ecto.Schema
  import Ecto.Changeset

  schema "events" do
    field :description, :string
    field :name, :string
    field :when, :date
    belongs_to :usr, EventsApp.Usrs.Usr
    has_many :comments, EventsApp.Comments.Comment

    timestamps()
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:name, :when, :description, :usr_id])
    |> validate_required([:name, :when, :description, :usr_id])
  end
end
