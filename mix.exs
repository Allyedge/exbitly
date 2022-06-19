defmodule Exbitly.MixProject do
  use Mix.Project

  @description "An Elixir library to interact with the Bitly API."
  @source_url "https://github.com/Allyedge/exbitly"

  def project do
    [
      app: :exbitly,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      name: "Exbitly",
      description: @description,
      package: [
        maintainers: ["Alim Arslan Kaya"],
        licenses: ["MIT"],
        links: %{
          GitHub: @source_url
        }
      ],
      source_url: @source_url,
      docs: [
        main: "readme",
        extras: [
          "README.md"
        ]
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:httpoison, "~> 1.8"},
      {:poison, "~> 5.0"},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end
end
