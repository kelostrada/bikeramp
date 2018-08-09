defmodule BikerampWeb.PageController do
  use BikerampWeb, :controller

  def index(conn, _params) do
    redirect conn, to: "/index.html"
  end

end
