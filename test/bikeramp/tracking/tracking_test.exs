defmodule Bikeramp.TrackingTest do
  use Bikeramp.DataCase

  alias Bikeramp.Tracking

  describe "trips" do
    alias Bikeramp.Tracking.Trip

    @valid_attrs %{date: ~D[2010-04-17], destination_address: "some destination_address", distance: "120.5", price: "120.5", start_address: "some start_address"}
    @update_attrs %{date: ~D[2011-05-18], destination_address: "some updated destination_address", distance: "456.7", price: "456.7", start_address: "some updated start_address"}
    @invalid_attrs %{date: nil, destination_address: nil, distance: nil, price: nil, start_address: nil}

    def trip_fixture(attrs \\ %{}) do
      {:ok, trip} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Tracking.create_trip()

      trip
    end

    test "list_trips/0 returns all trips" do
      trip = trip_fixture()
      assert Tracking.list_trips() == [trip]
    end

    test "get_trip!/1 returns the trip with given id" do
      trip = trip_fixture()
      assert Tracking.get_trip!(trip.id) == trip
    end

    test "create_trip/1 with valid data creates a trip" do
      assert {:ok, %Trip{} = trip} = Tracking.create_trip(@valid_attrs)
      assert trip.date == ~D[2010-04-17]
      assert trip.destination_address == "some destination_address"
      assert trip.distance == Decimal.new("120.5")
      assert trip.price == Decimal.new("120.5")
      assert trip.start_address == "some start_address"
    end

    test "create_trip/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tracking.create_trip(@invalid_attrs)
    end

    test "update_trip/2 with valid data updates the trip" do
      trip = trip_fixture()
      assert {:ok, trip} = Tracking.update_trip(trip, @update_attrs)
      assert %Trip{} = trip
      assert trip.date == ~D[2011-05-18]
      assert trip.destination_address == "some updated destination_address"
      assert trip.distance == Decimal.new("456.7")
      assert trip.price == Decimal.new("456.7")
      assert trip.start_address == "some updated start_address"
    end

    test "update_trip/2 with invalid data returns error changeset" do
      trip = trip_fixture()
      assert {:error, %Ecto.Changeset{}} = Tracking.update_trip(trip, @invalid_attrs)
      assert trip == Tracking.get_trip!(trip.id)
    end

    test "delete_trip/1 deletes the trip" do
      trip = trip_fixture()
      assert {:ok, %Trip{}} = Tracking.delete_trip(trip)
      assert_raise Ecto.NoResultsError, fn -> Tracking.get_trip!(trip.id) end
    end

    test "change_trip/1 returns a trip changeset" do
      trip = trip_fixture()
      assert %Ecto.Changeset{} = Tracking.change_trip(trip)
    end
  end
end
