defmodule BikerampWeb.ChangesetViewTest do
  use BikerampWeb.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  test "renders changeset errors" do
    changeset =
      {%{}, %{name: :string}}
      |> Ecto.Changeset.cast(%{"name" => "test"}, [:name])
      |> Ecto.Changeset.validate_length(:name, min: 5)

    assert render(BikerampWeb.ChangesetView, "error.json", changeset: changeset) ==
           %{errors: %{name: ["should be at least 5 character(s)"]}}
  end


end
