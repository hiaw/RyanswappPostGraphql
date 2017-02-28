defmodule RyanswappPostGraphql.Schema do
  use Absinthe.Schema
  import_types RyanswappPostGraphql.Schema.Types

  query do
    field :posts, list_of(:post) do
      resolve &RyanswappPostGraphql.PostResolver.all/2
    end

    field :users, list_of(:user) do
      resolve &RyanswappPostGraphql.UserResolver.all/2
    end

    field :user, type: :user do
      resolve &RyanswappPostGraphql.UserResolver.find/2
    end
  end
end
