defmodule PentoWeb.PageController do
  use PentoWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end

  def lolz(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :lolz, layout: false)
  end
end
