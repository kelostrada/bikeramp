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

  @doc """
  Formats date into human readable format ignoring year.

  ## Examples

      iex> Bikeramp.Stats.Formatter.format_date!(~D[2018-07-31])
      "July, 31st"
      iex> Bikeramp.Stats.Formatter.format_date!(~D[2018-08-01])
      "August, 1st"
      iex> Bikeramp.Stats.Formatter.format_date!(~D[2018-08-02])
      "August, 2nd"
      iex> Bikeramp.Stats.Formatter.format_date!(~D[2018-08-03])
      "August, 3rd"
      iex> Bikeramp.Stats.Formatter.format_date!(~D[2018-08-08])
      "August, 8th"
      iex> Bikeramp.Stats.Formatter.format_date!(~D[2018-08-12])
      "August, 12th"
      iex> Bikeramp.Stats.Formatter.format_date!(~D[2018-08-21])
      "August, 21st"
      iex> Bikeramp.Stats.Formatter.format_date!(~D[2018-08-22])
      "August, 22nd"
      iex> Bikeramp.Stats.Formatter.format_date!(~D[2018-08-23])
      "August, 23rd"
      iex> Bikeramp.Stats.Formatter.format_date!(~D[2018-08-24])
      "August, 24th"
  """
  @spec format_date!(Date.t) :: String.t | no_return
  def format_date!(%Date{day: day} = date) do
    Timex.format!(date, "{Mfull}, {D}") <> day_suffix(day)
  end

  defp day_suffix(1), do: "st"
  defp day_suffix(2), do: "nd"
  defp day_suffix(3), do: "rd"
  defp day_suffix(day) when day >= 4 and day <= 20, do: "th"
  defp day_suffix(21), do: "st"
  defp day_suffix(22), do: "nd"
  defp day_suffix(23), do: "rd"
  defp day_suffix(day) when day >= 24 and day <= 30, do: "th"
  defp day_suffix(31), do: "st"


end
