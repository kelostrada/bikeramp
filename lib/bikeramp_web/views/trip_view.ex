defmodule BikerampWeb.TripView do
  use BikerampWeb, :view
  alias BikerampWeb.TripView

  def render("show.json", %{trip: trip}) do
    %{data: render_one(trip, TripView, "trip.json")}
  end

  def render("trip.json", %{trip: trip}) do
    %{id: trip.id,
      start_address: trip.start_address,
      destination_address: trip.destination_address,
      price: trip.price,
      date: trip.date,
      distance: trip.distance}
  end
end
