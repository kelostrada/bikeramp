defmodule Bikeramp.StatsTest do
  use Bikeramp.DataCase

  alias Bikeramp.Stats
  doctest Stats


  describe "weekly/1" do

    test "gets stats with default unit" do
      insert(:trip, distance: 1000, price: 1.23, date: Date.utc_today)
      assert %{total_distance: 1000.0, total_price: Decimal.new(1.23), unit: "m"} == Bikeramp.Stats.weekly()
    end

    test "gets stats with m unit" do
      insert(:trip, distance: 1000, price: 1.23, date: Date.utc_today)
      assert %{total_distance: 1000.0, total_price: Decimal.new(1.23), unit: "m"} == Bikeramp.Stats.weekly("m")
    end

    test "gets stats with km unit" do
      insert(:trip, distance: 1000, price: 1.23, date: Date.utc_today)
      assert %{total_distance: 1.0, total_price: Decimal.new(1.23), unit: "km"} == Bikeramp.Stats.weekly("km")
    end

    test "gets error when wrong unit" do
      assert {:error, :wrong_unit} == Bikeramp.Stats.weekly("asd")
    end

  end

  describe "monthly/1" do

    test "gets stats with km units" do
      insert(:trip, distance: 1000, price: 1.23, date: Date.utc_today)
      [stat] = Bikeramp.Stats.monthly("km")
      assert stat.total_distance == 1.0
      assert stat.avg_ride == 1.0
      assert stat.unit == "km"
    end

    test "gets stats with m units" do
      insert(:trip, distance: 1000, price: 1.23, date: Date.utc_today)
      [stat] = Bikeramp.Stats.monthly("m")
      assert stat.total_distance == 1000.0
      assert stat.avg_ride == 1000.0
      assert stat.unit == "m"
    end

    test "gets stats with default units" do
      insert(:trip, distance: 1000, price: 1.23, date: Date.utc_today)
      [stat] = Bikeramp.Stats.monthly()
      assert stat.total_distance == 1000.0
      assert stat.avg_ride == 1000.0
      assert stat.unit == "m"
    end

    test "gets error when wrong unit" do
      assert {:error, :wrong_unit} == Bikeramp.Stats.monthly("asd")
    end

  end


end
