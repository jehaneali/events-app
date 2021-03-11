defmodule EventsApp.Usrs.Usr do
  use Ecto.Schema
  import Ecto.Changeset

  schema "usrs" do
    field :email, :string
    field :name, :string
    has_many :posts, EventsApp.Events.Event

    timestamps()
  end

  @doc false
  def changeset(usr, attrs) do
    usr
    |> cast(attrs, [:name, :email])
    |> validate_required([:name, :email])
  end
end
