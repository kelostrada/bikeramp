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

end
