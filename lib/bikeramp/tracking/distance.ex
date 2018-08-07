defmodule Bikeramp.Tracking.Distance do
  require Logger

  @service Application.get_env(:bikeramp, :maps_service)

  def get_distance(origin, destination) do
    case @service.distance(origin, destination) do
      {:error, status, error_message} ->
        Logger.error "#{@service} error - #{status} #{error_message}"
        {:error, status}
      {:ok, result} -> handle_result(result)
    end
  end

  defp handle_result(%{"rows" => [%{"elements" => [element | _]} | _]}) do
    case element do
      %{"status" => "OK", "distance" => %{"value" => distance}} ->
        {:ok, distance}
      %{"status" => status} ->
        {:error, status}
    end
  end

end
