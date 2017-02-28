defmodule RyanswappPostGraphql.Router do
  use RyanswappPostGraphql.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :graphql do
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
    plug RyanswappPostGraphql.Web.Context
  end

  scope "/", RyanswappPostGraphql do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/api" do
    pipe_through :graphql

    forward "/", Absinthe.Plug,
      schema: RyanswappPostGraphql.Schema
  end

  forward "/graphiql", Absinthe.Plug.GraphiQL,
    schema: RyanswappPostGraphql.Schema

  # Other scopes may use custom stacks.
  # scope "/api", RyanswappPostGraphql do
  #   pipe_through :api
  # end
end
