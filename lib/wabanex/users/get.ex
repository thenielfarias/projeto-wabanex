defmodule Wabanex.Users.Get do
  alias Ecto.UUID
  alias Wabanex.{Repo, User}

  def call(id) do
    id
    |> UUID.cast()
    |> handle_responde()
  end

  defp handle_responde(:error) do
    {:error, "Invalid UUID"}
  end

  defp handle_responde({:ok, uuid}) do
    case Repo.get(User, uuid) do
      nil -> {:user, "User not found"}
      user -> {:ok, user}
    end
  end
end
