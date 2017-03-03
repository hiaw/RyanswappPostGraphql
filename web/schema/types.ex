import Ecto.Query, only: [where: 2]

defmodule RyanswappPostGraphql.Schema.Types do
  alias Absinthe.Relay
  alias RyanswappPostGraphql.Repo
  alias RyanswappPostGraphql.Post

  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema.Notation
  use Absinthe.Ecto, repo: RyanswappPostGraphql.Repo

  # defp list(args, %{source: user}) do
  #   IO.inspect args
  #   conn = Post
  #     |> where(user_id: ^user.id)
  #     |> Relay.Connection.from_query(&Repo.all/1, args, %{max: 10})
  #   {:ok, conn}
  # end

  node object :user do
    field :id, :id
    field :name, :string
    field :email, :string
    connection field :posts, node_type: :post do
      resolve fn
      args, %{source: user} ->
        conn = Post
        |> where(user_id: ^user.id)
        |> Relay.Connection.from_query(&Repo.all/1, args, %{max: 10})
        {:ok, conn}
      end
    end
  end

  node object :post do
    field :id, :id
    field :title, :string
    field :body, :string
    field :user, :user, resolve: assoc(:user)
  end

  connection node_type: :user
  connection node_type: :post

  object :session do
    field :token, :string
  end
end
