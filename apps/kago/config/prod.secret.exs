# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#  This file should not be checked in git repository in general,  #
#  but I commit because this is required to build docker image.   #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

use Mix.Config

config :kago, Kago.Web.Endpoint,
  secret_key_base: "9okKISeJbpQILC4W5qzyvo3TCTBXpG+fp8BpMofT522zG4DCbeyZ2gS7FeV75lW+"

# Configure your database
config :kago, Kago.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "kago_prod",
  pool_size: 15
