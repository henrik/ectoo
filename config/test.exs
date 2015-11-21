use Mix.Config

config :ectoo, Ectoo.Repo,
  adapter: Ecto.Adapters.Postgres,
  pool: Ecto.Adapters.SQL.Sandbox,
  database: "ectoo_test",
  username: System.get_env("ECTOO_DB_USER") || System.get_env("USER")

# Don't show all queries during test run. Gets noisy, especially with the transactions.
config :logger, level: :info
