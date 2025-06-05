defmodule ChatAppWeb.Router do
  use ChatAppWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {ChatAppWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", ChatAppWeb do
    pipe_through :browser
    live "/", ChatLive, :index
  end

  if Application.compile_env(:chat_app, :dev_routes) do
    import Phoenix.LiveDashboard.Router
    scope "/dev" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: ChatAppWeb.Telemetry
    end
  end
end
