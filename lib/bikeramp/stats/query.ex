defmodule Bikeramp.Stats.Query do
  @moduledoc """
  Queries for Stats module
  """

  import Ecto.Query
  alias Bikeramp.Repo
  alias Bikeramp.Tracking.Trip

  @doc """
  Returns weekly stats - total distance and total price

  ## Examples

      iex> Bikeramp.Stats.Query.weekly(Date.utc_today)
      %{total_distance: 0, total_price: Decimal.new(0)}

  """
  @spec weekly(Date.t) :: %{
    total_distance: integer,
    total_price: Decimal.t
  }
  def weekly(%Date{} = date) do
    day = Date.day_of_week(date) - 1 # substract one day because we start counting from 1 (monday)
    week_start = Date.add(date, -day)
    week_end = Date.add(week_start, 7)

    (from t in Trip,
    where: t.date >= ^week_start,
    where: t.date < ^week_end,
    select: %{
      total_distance: fragment("COALESCE(SUM(?), 0)", t.distance),
      total_price: fragment("COALESCE(SUM(?), 0)", t.price),
    })
    |> Repo.one


  end

end
