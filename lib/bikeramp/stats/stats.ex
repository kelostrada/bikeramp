defmodule Bikeramp.Stats do
  @moduledoc """
  The Stats context.
  """
  alias Bikeramp.Stats.Query

  @doc """
  Returns the weekly stats for today

  ## Examples

      iex> Bikeramp.Stats.weekly()
      %{total_distance: 0.0, total_price: Decimal.new(0), unit: "m"}

  """
  @spec weekly(String.t) :: Query.weekly_stat
  def weekly(unit \\ "m")
  def weekly(unit) when unit in ["m", "km"] do
    result =
      Query.weekly(Date.utc_today)
      |> Map.put(:unit, unit)

    case unit do
      "m" -> %{result | total_distance: result.total_distance / 1}
      "km" -> %{result | total_distance: result.total_distance / 1000}
    end
  end
  def weekly(_unit) do
    {:error, :wrong_unit}
  end


  @doc """
  Returns the monthly stats for today

  ## Examples

      iex> Bikeramp.Stats.monthly()
      []

  """
  @spec monthly() :: Query.monthly_stat
  def monthly(unit \\ "m")
  def monthly(unit) when unit in ["m", "km"] do
    Query.monthly(Date.utc_today)
    |> Enum.map(&update_monthly_stat(&1, unit))
  end
  def monthly(_unit) do
    {:error, :wrong_unit}
  end


  defp update_monthly_stat(%{total_distance: total_distance, avg_ride: avg_ride} = stat, unit) do
    stat =
      stat
      |> Map.put(:unit, unit)

    case unit do
      "m" -> %{stat | total_distance: total_distance / 1, avg_ride: avg_ride / 1}
      "km" -> %{stat | total_distance: total_distance / 1000, avg_ride: avg_ride / 1000}
    end
  end

end
