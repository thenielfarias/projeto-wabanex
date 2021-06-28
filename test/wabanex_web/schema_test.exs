defmodule WabanexWeb.SchemaTest do
  use WabanexWeb.ConnCase, async: true

  alias Wabanex.User
  alias Wabanex.Users.Create

  describe "users query" do
    test "when valid id given, returns user" %{conn: conn} do
      params = %{email: "daniel.farias@ufpel.edu.br", name: "Daniel Farias", password: "311090"}

    {:ok, %User{id: user_id}} = Create.call(params)

    query = """
      {
        getUser(id: "#{user_id}"){
          name
          email
        }
      }
    """

    response =
      conn
      |> post("/api/graphql", %{query: query})
      |> json_response(:ok)

    expected_response = %{
      "data" => %{
        "getUser" => %{
          "email" => "daniel.farias@ufpel.edu.br",
          "name" => "Daniel Farias"
        }
      }
    }

    assert response == expected_response
    end
  end
end
