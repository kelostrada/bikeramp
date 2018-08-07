defmodule Bikeramp.TrackingTest do
  use Bikeramp.DataCase

  alias Bikeramp.Tracking

  describe "trips" do
    alias Bikeramp.Tracking.Trip

    @valid_attrs %{date: ~D[2010-04-17], destination_address: "Plac Europejski 2, Warszawa, Polska", price: "120.5", start_address: "Plac Europejski 2, Warszawa, Polska"}
    @update_attrs %{date: ~D[2011-05-18], destination_address: "Wspólna 50, Warszawa, Polska", distance: "4567", price: "456.7", start_address: "Wspólna 50, Warszawa, Polska"}
    @invalid_attrs %{date: nil, destination_address: nil, distance: nil, price: nil, start_address: nil}
    @non_existing_address_attrs %{date: ~D[2010-04-17], destination_address: "not_existing, not_existing, not_existing", price: "120.5", start_address: "not_existing, not_existing, not_existing"}
    @invalid_address_attrs %{date: ~D[2010-04-17], destination_address: "test", price: "120.5", start_address: "test, test"}

    test "list_trips/0 returns all trips" do
      trip = insert(:trip)
      assert Tracking.list_trips() == [trip]
    end

    test "get_trip!/1 returns the trip with given id" do
      trip = insert(:trip)
      assert Tracking.get_trip!(trip.id) == trip
    end

    test "create_trip/1 with valid data creates a trip" do
      assert {:ok, %Trip{} = trip} = Tracking.create_trip(@valid_attrs)
      assert trip.date == ~D[2010-04-17]
      assert trip.destination_address == "Plac Europejski 2, Warszawa, Polska"
      assert trip.distance == 2700
      assert trip.price == Decimal.new("120.5")
      assert trip.start_address == "Plac Europejski 2, Warszawa, Polska"
    end

    test "create_trip/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tracking.create_trip(@invalid_attrs)
    end

    test "create_trip/1 with non existing addresses returns error changeset" do
      assert {:error, %Ecto.Changeset{} = changeset} = Tracking.create_trip(@non_existing_address_attrs)
      assert "cannot be calculated" in errors_on(changeset).distance
      assert [distance: {"cannot be calculated", [status: "NOT_FOUND"]}] == changeset.errors
    end

    test "create_trip/1 with invalid addresses returns error changeset" do
      assert {:error, %Ecto.Changeset{} = changeset} = Tracking.create_trip(@invalid_address_attrs)
      assert "has invalid format" in errors_on(changeset).destination_address
      assert "has invalid format" in errors_on(changeset).start_address
    end

    test "update_trip/2 with valid data updates the trip" do
      trip = insert(:trip)
      assert {:ok, trip} = Tracking.update_trip(trip, @update_attrs)
      assert %Trip{} = trip
      assert trip.date == ~D[2011-05-18]
      assert trip.destination_address == "Wspólna 50, Warszawa, Polska"
      assert trip.distance == 4567
      assert trip.price == Decimal.new("456.7")
      assert trip.start_address == "Wspólna 50, Warszawa, Polska"
    end

    test "update_trip/2 with invalid data returns error changeset" do
      trip = insert(:trip)
      assert {:error, %Ecto.Changeset{}} = Tracking.update_trip(trip, @invalid_attrs)
      assert trip == Tracking.get_trip!(trip.id)
    end

    test "delete_trip/1 deletes the trip" do
      trip = insert(:trip)
      assert {:ok, %Trip{}} = Tracking.delete_trip(trip)
      assert_raise Ecto.NoResultsError, fn -> Tracking.get_trip!(trip.id) end
    end

    test "change_trip/1 returns a trip changeset" do
      trip = insert(:trip)
      assert %Ecto.Changeset{} = Tracking.change_trip(trip)
    end
  end
end
