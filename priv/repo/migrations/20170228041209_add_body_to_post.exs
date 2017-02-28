defmodule RyanswappPostGraphql.Repo.Migrations.AddBodyToPost do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      add :body, :text
    end
  end
end
