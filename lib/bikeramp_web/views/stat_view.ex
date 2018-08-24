defmodule BikerampWeb.StatView do
  use BikerampWeb, :view
  alias BikerampWeb.StatView

  import Bikeramp.Stats.Formatter

  def render("weekly.json", %{stat: stat}) do
    %{
      total_distance: stat.total_distance,
      total_price: stat.total_price |> format_price("PLN"),
      unit: stat.unit
    }
  end

  def render("monthly.json", %{stats: stats}) do
    render_many(stats, StatView, "montly_stat.json")
  end

  def render("montly_stat.json", %{stat: stat}) do
    %{
      day: stat.day |> format_day!(),
      total_distance: stat.total_distance,
      avg_ride: stat.avg_ride,
      avg_price: stat.avg_price |> format_price("PLN"),
      unit: stat.unit
    }
  end
end
