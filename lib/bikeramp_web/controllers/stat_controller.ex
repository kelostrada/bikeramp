defmodule BikerampWeb.StatController do
  use BikerampWeb, :controller
  alias Bikeramp.Stats

  def weekly(conn, _params) do
    render conn, "weekly.json", stat: Stats.weekly()
  end

  def monthly(conn, _params) do
    render conn, "monthly.json", stats: Stats.monthly()
  end

end
