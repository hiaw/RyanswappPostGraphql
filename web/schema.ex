defmodule RyanswappPostGraphql.Schema do
  use Absinthe.Schema
  use Absinthe.Relay.Schema
  import_types RyanswappPostGraphql.Schema.Types

  node interface do
    resolve_type fn
      %RyanswappPostGraphql.User{}, _ -> :user
      %RyanswappPostGraphql.Post{}, _ -> :post
      _, _ -> nil
    end
  end


  query do
    field :posts, list_of(:post) do
      resolve &RyanswappPostGraphql.PostResolver.all/2
    end

    field :post, :post do
      arg :id, non_null(:integer)
      resolve &RyanswappPostGraphql.PostResolver.find/2
    end

    field :users, list_of(:user) do
      resolve &RyanswappPostGraphql.UserResolver.all/2
    end

    field :user, type: :user do
      arg :id, non_null(:integer)
      resolve &RyanswappPostGraphql.UserResolver.find/2
    end

    node field do
      resolve fn
        %{type: :user, id: id}, _ ->
          RyanswappPostGraphql.UserResolver.find(%{id: id}, %{})
        %{type: :post, id: id}, _ ->
          RyanswappPostGraphql.PostResolver.find(%{id: id}, %{})
      end
    end
  end

  input_object :update_post_params do
    field :title, non_null(:string)
    field :body, non_null(:string)
    field :user_id, non_null(:integer)
  end

  input_object :update_user_params do
    field :name, :string
    field :email, :string
    field :password, :string
  end

  mutation do
    field :login, type: :session do
      arg :email, non_null(:string)
      arg :password, non_null(:string)

      resolve &RyanswappPostGraphql.UserResolver.login/2
    end

    field :update_user, type: :user do
      arg :id, non_null(:integer)
      arg :user, :update_user_params

      resolve &RyanswappPostGraphql.UserResolver.update/2
    end

    field :create_post, type: :post do
      arg :title, non_null(:string)
      arg :body, non_null(:string)
      arg :user_id, non_null(:integer)

      resolve &RyanswappPostGraphql.PostResolver.create/2
    end

    field :update_post, type: :post do
      arg :id, non_null(:integer)
      arg :post, :update_post_params

      resolve &RyanswappPostGraphql.PostResolver.update/2
    end

    field :delete_post, type: :post do
      arg :id, non_null(:integer)

      resolve &RyanswappPostGraphql.PostResolver.delete/2
    end
  end
end
