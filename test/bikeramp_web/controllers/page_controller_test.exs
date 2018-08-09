defmodule BikerampWeb.PageControllerTest do
  use BikerampWeb.ConnCase

  test "redirects to index.html", %{conn: conn} do
    conn = get conn, page_path(conn, :index)
    assert redirected_to(conn) == "/index.html"
  end

end
