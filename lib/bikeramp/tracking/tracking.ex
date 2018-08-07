defmodule Bikeramp.Tracking do
  @moduledoc """
  The Tracking context.
  """

  import Ecto.Query, warn: false
  import Ecto.Changeset, only: [get_change: 2, put_change: 3, add_error: 4]
  alias Bikeramp.Repo

  alias Bikeramp.Tracking.{Distance, Trip}

  @doc """
  Returns the list of trips.

  ## Examples

      iex> list_trips()
      [%Trip{}, ...]

  """
  @spec list_trips() :: [Trip.t]
  def list_trips do
    Repo.all(Trip)
  end

  @doc """
  Gets a single trip.

  Raises `Ecto.NoResultsError` if the Trip does not exist.

  ## Examples

      iex> get_trip!(123)
      %Trip{}

      iex> get_trip!(456)
      ** (Ecto.NoResultsError)

  """
  @spec get_trip!(integer) :: Trip.t
  def get_trip!(id), do: Repo.get!(Trip, id)

  @doc """
  Creates a trip.

  ## Examples

      iex> create_trip(%{field: value})
      {:ok, %Trip{}}

      iex> create_trip(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  @spec create_trip(map) :: {:ok, Trip.t} | {:error, Ecto.Changeset.t}
  def create_trip(attrs \\ %{}) do
    %Trip{}
    |> Trip.changeset(attrs)
    |> update_distance()
    |> Repo.insert()
  end

  @spec update_distance(Ecto.Changeset.t) :: Ecto.Changeset.t
  defp update_distance(%{valid?: true} = changeset) do
    start_address = get_change(changeset, :start_address)
    destination_address = get_change(changeset, :destination_address)
    case Distance.get_distance(start_address, destination_address) do
      {:ok, distance} -> put_change(changeset, :distance, distance)
      {:error, error} -> add_error(changeset, :distance, "cannot be calculated", status: error)
    end
  end
  defp update_distance(changeset), do: changeset

  @doc """
  Updates a trip.

  ## Examples

      iex> update_trip(trip, %{field: new_value})
      {:ok, %Trip{}}

      iex> update_trip(trip, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  @spec update_trip(Trip.t, map) :: {:ok, Trip.t} | {:error, Ecto.Changeset.t}
  def update_trip(%Trip{} = trip, attrs) do
    trip
    |> Trip.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Trip.

  ## Examples

      iex> delete_trip(trip)
      {:ok, %Trip{}}

      iex> delete_trip(trip)
      {:error, %Ecto.Changeset{}}

  """
  @spec delete_trip(Trip.t) :: {:ok, Trip.t} | {:error, Ecto.Changeset.t}
  def delete_trip(%Trip{} = trip) do
    Repo.delete(trip)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking trip changes.

  ## Examples

      iex> change_trip(trip)
      %Ecto.Changeset{source: %Trip{}}

  """
  @spec change_trip(Trip.t) :: Ecto.Changeset.t
  def change_trip(%Trip{} = trip) do
    Trip.changeset(trip, %{})
  end
end
