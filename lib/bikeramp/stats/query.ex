defmodule Bikeramp.Stats.Query do
  @moduledoc """
  Queries for Stats module
  """

  import Ecto.Query
  alias Bikeramp.Repo
  alias Bikeramp.Tracking.Trip

  @type monthly_stat :: %{
    day: Date.t,
    total_distance: integer,
    avg_ride: integer,
    avg_price: Decimal.t
  }

  @type weekly_stat :: %{
    total_distance: integer,
    total_price: Decimal.t
  }

  @doc """
  Returns weekly stats - total distance and total price.
  Requires Date parameter - usually used as todays date to indicate the week.

  ## Examples

      iex> Bikeramp.Stats.Query.weekly(Date.utc_today)
      %{total_distance: 0, total_price: Decimal.new(0)}

  """
  @spec weekly(Date.t) :: weekly_stat
  def weekly(%Date{} = date) do
    day = Date.day_of_week(date) - 1 # substract one day because we start counting from 1 (monday)
    week_start = Date.add(date, -day)
    week_end = Date.add(week_start, 7)

    (from t in Trip,
    where: t.date >= ^week_start,
    where: t.date < ^week_end,
    select: %{
      total_distance: type(fragment("COALESCE(SUM(?), 0)", t.distance), :integer),
      total_price: fragment("COALESCE(SUM(?), 0)", t.price),
    })
    |> Repo.one
  end

  @doc """
  Returns monthly stats aggregated by day.
  Requires Date parameter - usually used as todays date to indicate the month.

  ## Examples

      iex> Bikeramp.Stats.Query.monthly(Date.utc_today)
      []

      iex> import Bikeramp.Factory
      iex> insert(:trip, price: 1, distance: 1, date: Date.utc_today)
      iex> Bikeramp.Stats.Query.monthly(Date.utc_today)
      [%{day: Date.utc_today, total_distance: 1, avg_ride: 1, avg_price: Decimal.new("1.00000000000000000000")}]

  """
  @spec monthly(Date.t) :: [monthly_stat]
  def monthly(%Date{month: month}) do
    (from t in Trip,
    where: fragment("EXTRACT(MONTH FROM ?) = ?", t.date, ^month),
    group_by: t.date,
    order_by: [asc: t.date],
    select: %{
      day: t.date,
      total_distance: type(sum(t.distance), :integer),
      avg_ride: type(avg(t.distance), :integer),
      avg_price: avg(t.price)
    })
    |> Repo.all
  end

end
