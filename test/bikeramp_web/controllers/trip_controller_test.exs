defmodule BikerampWeb.TripControllerTest do
  use BikerampWeb.ConnCase, async: false

  alias Bikeramp.Tracking
  alias Bikeramp.Tracking.Trip

  @create_attrs %{date: ~D[2010-04-17], destination_address: "some destination_address", distance: "120.5", price: "120.5", start_address: "some start_address"}
  @invalid_attrs %{date: nil, destination_address: nil, distance: nil, price: nil, start_address: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "create trip" do
    test "renders trip when data is valid", %{conn: conn} do
      conn = post conn, trip_path(conn, :create), trip: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      distance = Decimal.new("120.5")
      price = Decimal.new("120.5")

      %Trip{
        id: ^id,
        date: ~D[2010-04-17],
        destination_address: "some destination_address",
        distance: ^distance,
        price: ^price,
        start_address: "some start_address"
      } = Tracking.get_trip!(id)
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, trip_path(conn, :create), trip: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

end
