defmodule RyanswappPostGraphql.PostResolver do
  alias RyanswappPostGraphql.Repo
  alias RyanswappPostGraphql.Post

  def all(_args, _info) do
    {:ok, Repo.all(Post)}
  end

  def create(args, _info) do
    %Post{}
    |> Post.changeset(args)
    |> Repo.insert
  end

  def update(%{id: id, post: post_params}, _info) do
    Repo.get!(Post, id)
    |> Post.changeset(post_params)
    |> Repo.insert
  end

  def delete(%{id: id}, _info) do
    post = Repo.get!(Post, id)
    Repo.delete(post)
  end
end
