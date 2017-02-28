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
end
