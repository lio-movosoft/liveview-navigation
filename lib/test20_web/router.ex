defmodule Test20Web.Router do
  use Test20Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {Test20Web.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Test20Web do
    pipe_through :browser

    get "/", PageController, :home
  end

  scope "/", Test20Web do
    pipe_through :browser

    live_session :default do
      live "/users", UserLive.Index, :index
      live "/users/new", UserLive.Index, :new
      live "/users/:id/edit", UserLive.Index, :edit

      live "/users/:id", UserLive.Show, :show
      live "/users/:id/show/edit", UserLive.Show, :edit
      # end
      # live_session :default2 do
      live "/stuffies", StuffyLive.Index, :index
      live "/stuffies/new", StuffyLive.Index, :new
      live "/stuffies/:id/edit", StuffyLive.Index, :edit

      live "/stuffies/:id", StuffyLive.Show, :show
      live "/stuffies/:id/show/edit", StuffyLive.Show, :edit
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", Test20Web do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:test20, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: Test20Web.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
