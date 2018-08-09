defmodule BikerampWeb.TripControllerTest do
  use BikerampWeb.ConnCase, async: false

  alias Bikeramp.Tracking
  alias Bikeramp.Tracking.Trip

  @create_attrs %{date: ~D[2010-04-17], destination_address: "Plac Europejski 2, Warszawa, Polska", price: "120.5", start_address: "Wspólna 50, Warszawa, Polska"}
  @invalid_attrs %{date: nil, destination_address: nil, distance: nil, price: nil, start_address: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "create trip" do
    test "renders trip when data is valid", %{conn: conn} do
      conn = post conn, trip_path(conn, :create), @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      distance = 2700
      price = Decimal.new("120.5")

      %Trip{
        id: ^id,
        date: ~D[2010-04-17],
        destination_address: "Plac Europejski 2, Warszawa, Polska",
        distance: ^distance,
        price: ^price,
        start_address: "Wspólna 50, Warszawa, Polska"
      } = Tracking.get_trip!(id)
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, trip_path(conn, :create), @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

end
