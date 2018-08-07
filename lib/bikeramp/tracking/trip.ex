defmodule Bikeramp.Tracking.Trip do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  alias Bikeramp.Tracking.Trip

  @type t :: %Trip{
    date: Date.t,
    start_address: String.t,
    destination_address: String.t,
    distance: integer,
    price: Decimal.t
  }

  schema "trips" do
    field :date, :date
    field :destination_address, :string
    field :distance, :integer
    field :price, :decimal
    field :start_address, :string

    timestamps()
  end


  @doc false
  @spec changeset(Trip.t, map) :: Ecto.Changeset.t
  def changeset(trip, attrs) do
    trip
    |> cast(attrs, [:start_address, :destination_address, :price, :date, :distance])
    |> validate_required([:start_address, :destination_address, :price, :date])
  end
end
