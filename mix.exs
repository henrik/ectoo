defmodule Ectoo.Mixfile do
  use Mix.Project

  def project do
    [
      app: :ectoo,
      version: "0.2.0",
      elixir: "~> 1.1",
      elixirc_paths: elixirc_paths(Mix.env),
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      description: "Make simple things easy in Ecto, e.g. Ectoo.max(MyModel, :age). Also .count, .min, .max, .avg.",
      package: package,
      deps: deps,
      aliases: aliases,
    ]
  end

  defp package do
    [
      maintainers: ["Henrik Nyh"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/henrik/ectoo",
      },
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: applications(Mix.env)]
  end

  defp applications(:test), do: [:logger, :postgrex]
  defp applications(_), do: [:logger]

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:ecto, "~> 2.0"},
      {:postgrex, "> 0.0.0", optional: true},
    ]
  end

  defp aliases do
    [
      "test.setup": ["ecto.create", "ecto.migrate"],
      "test.reset": ["ecto.drop", "test.setup"],
    ]
  end
end
