defmodule LivelinksWeb.UserLiveTest do
  use LivelinksWeb.ConnCase

  import Phoenix.LiveViewTest
  import Livelinks.AccountsFixtures

  describe "Index" do
    test "check if the user exists", %{conn: conn} do
      username = "some-random-username"
      html_tag = "<div class=\"text-3xl text-center\">the user #{username} does not exists.</div>"

      {:ok, view, _html} = live(conn, "/#{username}")
      assert render(view) |> String.contains?(html_tag)
    end
  end
end
