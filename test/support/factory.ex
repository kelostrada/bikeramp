defmodule Bikeramp.Factory do
  use ExMachina.Ecto, repo: Bikeramp.Repo

  def trip_factory do
    %Bikeramp.Tracking.Trip{
      date: ~D[2018-08-01],
      start_address: "Wspólna 50, Warszawa, Polska",
      destination_address: "plac Europejski 2, Warszawa, Polska",
      distance: 2700,
      price: 100
    }
  end

end
