defmodule Bikeramp.MapsStub do

  def distance(origin, destination, options \\ [])
  def distance("error", "error", _options) do
    {:error, "ERROR", "Some error message"}
  end
  def distance("not_existing", "not_existing", _options) do
    result = %{
      "destination_addresses" => ["not_existing"],
      "origin_addresses" => ["not_existing"],
      "rows" => [
        %{"elements" => [
            %{
              "status" => "NOT_FOUND"
            }
          ]
        }
      ]
    }
    {:ok, result}
  end
  def distance(origin, destination, _options) do
    result = %{
      "destination_addresses" => [origin],
      "origin_addresses" => [destination],
      "rows" => [
        %{"elements" => [
            %{
              "distance" => %{
                "text" => "2.7 km",
                "value" => 2700
              },
              "duration" => %{
                "text" => "8 mins",
                "value" => 496
              },
              "status" => "OK"
            }
          ]
        }
      ]
    }
    {:ok, result}
  end

end
