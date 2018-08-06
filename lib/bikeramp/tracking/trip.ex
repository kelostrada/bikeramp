defmodule Bikeramp.Tracking.Trip do
  use Ecto.Schema
  import Ecto.Changeset


  schema "trips" do
    field :date, :date
    field :destination_address, :string
    field :distance, :decimal
    field :price, :decimal
    field :start_address, :string

    timestamps()
  end

  @doc false
  def changeset(trip, attrs) do
    trip
    |> cast(attrs, [:start_address, :destination_address, :price, :date, :distance])
    |> validate_required([:start_address, :destination_address, :price, :date, :distance])
  end
end
