defmodule RyanswappPostGraphql.PostTest do
  use RyanswappPostGraphql.ModelCase

  alias RyanswappPostGraphql.Post

  @valid_attrs %{body: "some body", title: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Post.changeset(%Post{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Post.changeset(%Post{}, @invalid_attrs)
    refute changeset.valid?
  end
end
