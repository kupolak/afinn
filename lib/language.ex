defmodule Language do
  @moduledoc """
  Handles loading and parsing of AFINN sentiment dictionaries for different languages.

  This module provides functionality to read AFINN dictionary files and convert them
  into maps for efficient sentiment lookups.
  """

  @language_to_filename %{
    :en => "en.txt",
    :dk => "dk.txt"
  }

  @doc """
  Reads and parses the AFINN dictionary for the specified language.

  ## Parameters

    - `language` - Language identifier (`:en` for English, `:dk` for Danish)

  ## Returns

  A map where keys are words (strings) and values are sentiment scores (integers).

  ## Examples

      iex> dict = Language.read_dictionaries(:en)
      iex> Map.get(dict, "love")
      3
  """
  @spec read_dictionaries(:en | :dk) :: %{String.t() => integer()}
  def read_dictionaries(language) do
    filename = find_filename(language)
    read_word_file(filename)
  end

  defp find_filename(language) do
    filename = @language_to_filename[language]
    Path.join([__DIR__, "dictionaries", filename])
  end

  defp read_word_file(file) do
    {:ok, contents} = File.read(file)

    String.split(contents)
    |> Enum.chunk_every(2)
    |> Map.new(fn [k, v] -> {k, String.to_integer(v)} end)
  end
end
