defmodule BikerampWeb.StatController do
  use BikerampWeb, :controller
  alias Bikeramp.Stats

  def weekly(conn, params) do
    unit = Map.get(params, "unit", "m")
    render conn, "weekly.json", stat: Stats.weekly(unit)
  end

  def monthly(conn, params) do
    unit = Map.get(params, "unit", "m")
    render conn, "monthly.json", stats: Stats.monthly(unit)
  end

end
