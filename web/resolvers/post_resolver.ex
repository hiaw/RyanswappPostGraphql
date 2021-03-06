import Ecto.Query, only: [where: 2]

defmodule RyanswappPostGraphql.PostResolver do
  alias RyanswappPostGraphql.Repo
  alias RyanswappPostGraphql.Post

  def all(_args, %{context: %{current_user: %{id: id}}}) do
    posts = Post
    |> where(user_id: ^id)
    |> Repo.all

    {:ok, posts}
  end

  def all(_args, _info) do
    {:error, "Not Authorized"}
  end
  
  def find(%{id: id}, _info) do
    case Repo.get(Post, id) do
      nil -> {:error, "Post id #{id} not found"}
      post -> {:ok, post}
    end
  end

  def create(args, _info) do
    %Post{}
    |> Post.changeset(args)
    |> Repo.insert
  end

  def update(%{id: id, post: post_params}, _info) do
    Repo.get!(Post, id)
    |> Post.changeset(post_params)
    |> Repo.update
  end

  def delete(%{id: id}, _info) do
    post = Repo.get!(Post, id)
    Repo.delete(post)
  end
end
