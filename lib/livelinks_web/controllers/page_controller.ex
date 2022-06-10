defmodule LivelinksWeb.PageController do
  use LivelinksWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
