defmodule Bikeramp.Stats.Formatter do
  @moduledoc """
  Module for handling stats formatting.
  """

  @doc """
  Formats price with simple rules: 2 decimal places and currency name next to value

  ## Examples

      iex> Bikeramp.Stats.Formatter.format_price(Decimal.new(1.5), "PLN")
      "1.50PLN"

      iex> Bikeramp.Stats.Formatter.format_price(Decimal.new(100.234), "PLN")
      "100.23PLN"

      iex> Bikeramp.Stats.Formatter.format_price(Decimal.new(100), "PLN")
      "100.00PLN"
  """
  @spec format_price(Decimal.t, String.t) :: String.t
  def format_price(%Decimal{} = value, currency) do
    "#{Decimal.round(value, 2)}#{currency}"
  end


  @doc """
  Formats distance using kilometers as base. Expects distance to be in meters.
  Returns values formatted to one decimal place max.

  ## Examples

      iex> Bikeramp.Stats.Formatter.format_distance(1000)
      "1km"
      iex> Bikeramp.Stats.Formatter.format_distance(1500)
      "1.5km"
      iex> Bikeramp.Stats.Formatter.format_distance(1501)
      "1.5km"
  """
  @spec format_distance(integer) :: String.t
  def format_distance(distance) when is_integer(distance) do
    if :erlang.rem(distance, 1000) == 0 do
      "#{div(distance, 1000)}km"
    else
      :erlang.float_to_binary(distance / 1000, [decimals: 1]) <> "km"
    end

  end


end
