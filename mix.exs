defmodule Afinn.MixProject do
  use Mix.Project

  def project do
    [
      app: :afinn,
      version: "0.3.0",
      elixir: "~> 1.0",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false}
    ]
  end

  defp description() do
    "Sentiment analysis in Elixir. Languages supported: English, Danish, Finnish, French, Polish, Swedish, Turkish, and Emoticons"
  end

  defp package() do
    [
      files: ~w(lib .formatter.exs mix.exs mix.lock README.md LICENSE.md CHANGELOG.md),
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/kupolak/afinn"}
    ]
  end
end
