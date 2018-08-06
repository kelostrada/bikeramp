defmodule BikerampWeb.TripController do
  use BikerampWeb, :controller

  alias Bikeramp.Tracking
  alias Bikeramp.Tracking.Trip

  action_fallback BikerampWeb.FallbackController

  def create(conn, %{"trip" => trip_params}) do
    with {:ok, %Trip{} = trip} <- Tracking.create_trip(trip_params) do
      conn
      |> put_status(:created)
      |> render("show.json", trip: trip)
    end
  end

end
