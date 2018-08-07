defmodule Bikeramp.Repo.Migrations.ChangeDistanceToInteger do
  use Ecto.Migration

  def change do
    alter table(:trips) do
      modify :distance, :integer
    end
  end
end
