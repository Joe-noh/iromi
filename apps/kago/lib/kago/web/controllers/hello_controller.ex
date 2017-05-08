defmodule Kago.Web.HelloController do
  use Kago.Web, :controller

  import Ecto.Query

  def show(conn, _params) do
    data = Kago.Repo.all(from p in "pg_database", select: %{name: p.datname})
    json conn, data
  end
end
