defmodule Bikeramp.Tracking.Distance do
  @moduledoc """
  This module handles getting distance from one point to another.
  """
  require Logger

  @service Application.get_env(:bikeramp, :maps_service)

  @doc """
  Returns distance from one point to another.

  ## Examples

      iex> Bikeramp.Tracking.Distance.get_distance("Wspólna 50", "Plac Europejski 20")
      {:ok, 2700}
  """
  @spec get_distance(String.t, String.t) :: {:ok, integer} | {:error, String.t}
  def get_distance(origin, destination) do
    case @service.distance(origin, destination) do
      {:error, status, error_message} ->
        Logger.error "#{@service} error - #{status} #{error_message}"
        {:error, status}
      {:error, status} -> {:error, status}
      {:ok, result} -> handle_result(result)
    end
  end

  @spec handle_result(map) :: {:ok, integer} | {:error, String.t}
  defp handle_result(%{"rows" => [%{"elements" => [element | _]} | _]}) do
    case element do
      %{"status" => "OK", "distance" => %{"value" => distance}} ->
        {:ok, distance}
      %{"status" => status} ->
        {:error, status}
    end
  end

end
