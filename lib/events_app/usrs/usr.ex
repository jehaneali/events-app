defmodule EventsApp.Usrs.Usr do
  use Ecto.Schema
  import Ecto.Changeset

  schema "usrs" do
    field :email, :string
    field :name, :string
    has_many :events, EventsApp.Events.Event
    field :photo_hash, :string
    has_many :comments, EventsApp.Events.Comment

    timestamps()
  end

  @doc false
  def changeset(usr, attrs) do
    usr
    |> cast(attrs, [:name, :email, :photo_hash])
    |> validate_required([:name, :email, :photo_hash])
  end
end
