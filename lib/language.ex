defmodule Language do
  @moduledoc """
  Handles loading and parsing of AFINN sentiment dictionaries for different languages.

  This module provides functionality to read AFINN dictionary files and convert them
  into maps for efficient sentiment lookups.
  """

  @language_to_filename %{
    :en => "en.txt",
    :dk => "dk.txt",
    :fi => "fi.txt",
    :fr => "fr.txt",
    :pl => "pl.txt",
    :sv => "sv.txt",
    :tr => "tr.txt",
    :emoticon => "emoticon.txt"
  }

  @doc """
  Reads and parses the AFINN dictionary for the specified language.

  ## Parameters

    - `language` - Language identifier (`:en` for English, `:dk` for Danish, `:fi` for Finnish, `:fr` for French, `:pl` for Polish, `:sv` for Swedish, `:tr` for Turkish, `:emoticon` for Emoticons)

  ## Returns

  A map where keys are words (strings) and values are sentiment scores (integers).

  ## Examples

      iex> dict = Language.read_dictionaries(:en)
      iex> Map.get(dict, "love")
      3
  """
  @spec read_dictionaries(:en | :dk | :fi | :fr | :pl | :sv | :tr | :emoticon) :: %{String.t() => integer()}
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

    contents
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      # Split by any whitespace (tab or multiple spaces) to separate word/phrase from score
      # Use regex to split on one or more whitespace chars from the end
      parts = Regex.split(~r/\s+/, String.trim(line))
      {score, word_parts} = List.pop_at(parts, -1)
      word = Enum.join(word_parts, " ")
      {word, String.to_integer(score)}
    end)
    |> Map.new()
  end
end
