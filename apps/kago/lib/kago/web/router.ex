defmodule Kago.Web.Router do
  use Kago.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Kago.Web do
    pipe_through :api

    get "/hello", HelloController, :show
  end
end
