defmodule Bikeramp.Stats.QueryTest do
  use Bikeramp.DataCase
  alias Bikeramp.Stats.Query
  doctest Query

  describe "weekly/1" do

    test "gets empty weekly stats" do
      assert Query.weekly(~D[2010-01-01]) == %{total_distance: 0, total_price: Decimal.new(0)}
    end

    test "gets stats for one trip" do
      insert(:trip, distance: 1000, price: 1.23, date: ~D[2010-01-01])
      assert Query.weekly(~D[2010-01-01]) == %{total_distance: 1000, total_price: Decimal.new(1.23)}
    end

    test "gets summary stats for more trips" do
      insert(:trip, distance: 1000, price: 1.23, date: ~D[2018-08-06])
      insert(:trip, distance: 2000, price: 2.37, date: ~D[2018-08-07])
      insert(:trip, distance: 3000, price: 1.4, date: ~D[2018-08-08])
      assert Query.weekly(~D[2018-08-09]) == %{total_distance: 6000, total_price: Decimal.new("5.00")}
    end

    test "gets summary stats ignoring trips from different week" do
      insert(:trip, distance: 1000, price: 1.23, date: ~D[2018-08-05])
      insert(:trip, distance: 2000, price: 2.37, date: ~D[2018-08-07])
      insert(:trip, distance: 3000, price: 2.37, date: ~D[2018-08-13])
      assert Query.weekly(~D[2018-08-08]) == %{total_distance: 2000, total_price: Decimal.new("2.37")}
    end

  end


  describe "monthly/1" do

    test "gets empty monthly stats" do
      assert Query.monthly(~D[2010-01-01]) == []
    end

    test "gets stats for one trip" do
      insert(:trip, distance: 1000, price: 1.23, date: ~D[2010-01-01])
      [stat] = Query.monthly(~D[2010-01-01])

      assert stat.day == ~D[2010-01-01]
      assert stat.total_distance == 1000
      assert stat.avg_ride == 1000
      assert Decimal.equal?(stat.avg_price, Decimal.new(1.23))
    end

    test "gets summary stats for more trips" do
      insert(:trip, distance: 1000, price: 1.19, date: ~D[2018-08-06])
      insert(:trip, distance: 2000, price: 2.5, date: ~D[2018-08-06])
      insert(:trip, distance: 3000, price: 3.81, date: ~D[2018-08-06])
      [stat] = Query.monthly(~D[2018-08-01])

      assert stat.day == ~D[2018-08-06]
      assert stat.total_distance == 6000
      assert stat.avg_ride == 2000
      assert Decimal.equal?(stat.avg_price, Decimal.new(2.5))
    end

    test "gets rounded average for unequal division" do
      insert(:trip, distance: 1, date: ~D[2018-08-06])
      insert(:trip, distance: 1, date: ~D[2018-08-06])
      insert(:trip, distance: 2, date: ~D[2018-08-06])
      [stat] = Query.monthly(~D[2018-08-01])

      assert stat.avg_ride == 1

      insert(:trip, distance: 1, date: ~D[2018-08-06])
      insert(:trip, distance: 1, date: ~D[2018-08-06])
      insert(:trip, distance: 3, date: ~D[2018-08-06])
      [stat] = Query.monthly(~D[2018-08-01])

      assert stat.avg_ride == 2
    end

    test "gets summary stats from two days" do
      insert(:trip, distance: 1000, price: 1.23, date: ~D[2018-08-01])
      insert(:trip, distance: 2000, price: 2.37, date: ~D[2018-08-01])
      insert(:trip, distance: 1234, price: 1.45, date: ~D[2018-08-02])
      insert(:trip, distance: 4321, price: 2.55, date: ~D[2018-08-02])
      [stat1, stat2] = Query.monthly(~D[2018-08-15])

      assert stat1.day == ~D[2018-08-01]
      assert stat1.total_distance == 3000
      assert stat1.avg_ride == 1500
      assert Decimal.equal?(stat1.avg_price, Decimal.new(1.8))

      assert stat2.day == ~D[2018-08-02]
      assert stat2.total_distance == 5555
      assert stat2.avg_ride == 2778
      assert Decimal.equal?(stat2.avg_price, Decimal.new(2))
    end

    test "gets summary stats ignoring different months" do
      insert(:trip, distance: 1000, price: 1.23, date: ~D[2018-07-31])
      insert(:trip, distance: 2000, price: 2.37, date: ~D[2018-08-01])
      insert(:trip, distance: 3000, price: 2.37, date: ~D[2018-09-01])
      [stat] = Query.monthly(~D[2018-08-08])

      assert stat.day == ~D[2018-08-01]
      assert stat.total_distance == 2000
      assert stat.avg_ride == 2000
      assert Decimal.equal?(stat.avg_price, Decimal.new(2.37))
    end

  end

end
