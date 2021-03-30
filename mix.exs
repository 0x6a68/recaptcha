defmodule Recaptcha.Mixfile do
  use Mix.Project

  def project do
    [
      app: :recaptcha,
      version: "3.0.0",
      elixir: "~> 1.6",
      description: description(),
      deps: deps(),
      package: package(),
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      elixirc_paths: elixirc_paths(Mix.env()),
      # Test coverage:
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],

      # Dialyzer:
      dialyzer: [
        plt_add_deps: :apps_direct,
        plt_add_apps: [:jason]
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger, :httpoison, :eex]
    ]
  end

  defp description do
    """
    A simple reCaptcha package for Elixir applications, provides verification
    and templates for rendering forms with the reCaptcha widget
    """
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:httpoison, ">= 0.12.0"},
      {:jason, "~> 1.1", optional: true},
      {:credo, "~> 1.0", only: [:dev, :test], runtime: false},
      {:ex_doc, ">= 0.0.0", only: :dev},
      {:dialyxir, "~> 0.5", only: [:dev]},
      {:excoveralls, "~> 0.7.1", only: :test},
      {:mox, "~> 1.0", only: [:test]},
      {:bypass, "~> 2.1.0", only: [:test]}
    ]
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README.md", "LICENSE"],
      maintainers: ["Samuel Seay", "Nikita Sobolev", "Michael JustMikey"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/samueljseay/recaptcha"}
    ]
  end
end
