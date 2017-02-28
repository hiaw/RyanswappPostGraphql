# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     RyanswappPostGraphql.Repo.insert!(%RyanswappPostGraphql.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias RyanswappPostGraphql.User
alias RyanswappPostGraphql.Post
alias RyanswappPostGraphql.Repo

Repo.insert!(%User{name: "Some Guy", email: "some@guy.com"})
Repo.insert!(%User{name: "Another Guy", email: "another@guy.com"})

for _ <- 1..10 do
    Repo.insert!(%Post{
          title: Faker.Lorem.sentence,
          body: Faker.Lorem.paragraph,
          user_id: [1, 2] |> Enum.take_random(1) |> hd
                 })
end
