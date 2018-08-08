defmodule Bikeramp.Stats do
  @moduledoc """
  The Stats context.
  """
  alias Bikeramp.Stats.Query

  @doc """
  Returns the weekly stats for today

  ## Examples

      iex> Bikeramp.Stats.weekly()
      %{total_distance: 0, total_price: Decimal.new(0)}

  """
  @spec weekly() :: Query.weekly_stat
  def weekly, do: Query.weekly(Date.utc_today)


  @doc """
  Returns the monthly stats for today

  ## Examples

      iex> Bikeramp.Stats.monthly()
      []

  """
  @spec monthly() :: Query.monthly_stat
  def monthly, do: Query.monthly(Date.utc_today)

end
