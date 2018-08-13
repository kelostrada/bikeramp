defmodule BikerampWeb.StatControllerTest do
  use BikerampWeb.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "weekly stats" do

    test "renders empty stats", %{conn: conn} do
      conn = get conn, stat_path(conn, :weekly)
      assert json_response(conn, 200) == %{"total_distance" => "0km", "total_price" => "0.00PLN"}
    end

    test "renders stats", %{conn: conn} do
      insert(:trip, distance: 1000, price: 1.23, date: Date.utc_today)
      insert(:trip, distance: 2000, price: 2.37, date: Date.utc_today)
      insert(:trip, distance: 3000, price: 1.4, date: Date.utc_today)
      conn = get conn, stat_path(conn, :weekly)
      assert json_response(conn, 200) ==  %{"total_distance" => "6km", "total_price" => "5.00PLN"}
    end

  end

  describe "monthly stats" do

    test "renders empty stats", %{conn: conn} do
      conn = get conn, stat_path(conn, :monthly)
      assert json_response(conn, 200) == []
    end

    test "renders stats", %{conn: conn} do
      insert(:trip, distance: 1000, price: 1.19, date: Date.utc_today)
      insert(:trip, distance: 2000, price: 2.5, date: Date.utc_today)
      insert(:trip, distance: 3000, price: 3.81, date: Date.utc_today)
      conn = get conn, stat_path(conn, :monthly)
      assert json_response(conn, 200) == [
        %{
          "day" => Bikeramp.Stats.Formatter.format_day!(Date.utc_today),
          "total_distance" => "6km",
          "avg_ride" => "2km",
          "avg_price" => "2.50PLN"
        }
      ]
    end

  end

end
