defmodule Bikeramp.Repo.Migrations.CreateTrips do
  use Ecto.Migration

  def change do
    create table(:trips) do
      add :start_address, :text
      add :destination_address, :text
      add :price, :decimal
      add :date, :date
      add :distance, :decimal

      timestamps()
    end

  end
end
