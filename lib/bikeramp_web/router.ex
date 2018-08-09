defmodule BikerampWeb.Router do
  use BikerampWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BikerampWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/api", BikerampWeb do
    pipe_through :api

    post "/trips", TripController, :create

    get "/stats/weekly", StatController, :weekly
    get "/stats/monthly", StatController, :monthly
  end
end
