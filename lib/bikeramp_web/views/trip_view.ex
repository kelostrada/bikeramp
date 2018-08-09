defmodule BikerampWeb.TripView do
  use BikerampWeb, :view
  alias BikerampWeb.TripView

  import Bikeramp.Stats.Formatter

  def render("show.json", %{trip: trip}) do
    render_one(trip, TripView, "trip.json")
  end

  def render("trip.json", %{trip: trip}) do
    %{id: trip.id,
      start_address: trip.start_address,
      destination_address: trip.destination_address,
      price: trip.price |> format_price("PLN"),
      day: trip.date |> format_day!(),
      distance: trip.distance |> format_distance()}
  end
end
