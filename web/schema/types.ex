defmodule RyanswappPostGraphql.Schema.Types do
  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema.Notation
  use Absinthe.Ecto, repo: RyanswappPostGraphql.Repo

  node object :user do
    field :id, :id
    field :name, :string
    field :email, :string
    field :posts, list_of(:post), resolve: assoc(:posts)
  end

  node object :post do
    field :id, :id
    field :title, :string
    field :body, :string
    field :user, :user, resolve: assoc(:user)
  end

  object :session do
    field :token, :string
  end
end
