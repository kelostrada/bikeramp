defmodule Bikeramp.Tracking.DistanceTest do
  use Bikeramp.DataCase
  doctest Bikeramp.Tracking.Distance

  import ExUnit.CaptureLog
  alias Bikeramp.Tracking.Distance

  describe "get_distance/2" do
    test "gets stubbed distance" do
      assert {:ok, 2700} == Distance.get_distance("test origin", "test destination")
    end

    test "gets stubbed error" do
      assert capture_log(fn ->
        assert {:error, "ERROR"} == Distance.get_distance("error", "error")
      end) =~ "Some error message"
    end

    test "gets NOT_FOUND error" do
      assert {:error, "NOT_FOUND"} == Distance.get_distance("not_existing", "not_existing")
    end
  end

end
