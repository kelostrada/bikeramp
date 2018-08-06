defmodule BikerampWeb.Router do
  use BikerampWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", BikerampWeb do
    pipe_through :api

    post "/trips", TripController, :create
  end
end
