defmodule RyanswappPostGraphql.PageController do
  use RyanswappPostGraphql.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
