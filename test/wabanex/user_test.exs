defmodule Wabanex.UserTest do
  use Wabanex.DataCase, async: true

  alias Wabanex.User

  describe "changeset/1" do
    test "when all params valid, return valid changeset" do
      params = %{name: "Daniel Farias", email: "daniel.farias@ufpel.edu.br", password: "311090"}

      response = User.changeset(params)

      assert %Ecto.Changeset{
        valid?: true,
        changes: %{name: "Daniel Farias", email: "daniel.farias@ufpel.edu.br", password: "311090"},
        errors: []
      } = response
    end

    test "when invalid params, return invalid changeset" do
      params = %{name: "D", email: "daniel.farias@ufpel.edu.br"}

      response = User.changeset(params)

      expected_response = %{
        name: ["should be at least 2 character(s)"],
        password: ["can't be blank"]
      }

      assert errors_on(response) == expected_response
    end
  end
end
