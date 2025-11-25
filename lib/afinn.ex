defmodule Afinn do
  @moduledoc """
  Sentiment analysis using AFINN word lists.

  This module provides functions to analyze the sentiment of text using the AFINN lexicon,
  which assigns sentiment scores to words ranging from -5 (very negative) to +5 (very positive).

  ## Supported Languages

  - English (`:en`)
  - Danish (`:dk`)
  - Finnish (`:fi`)
  - French (`:fr`)
  - Polish (`:pl`)
  - Swedish (`:sv`)
  - Turkish (`:tr`)
  - Emoticons (`:emoticon`)

  ## Examples

      iex> Afinn.score("I love this!", :en)
      3

      iex> Afinn.score_to_words("I love this!", :en)
      :positive

      iex> Afinn.score("Terrible product!", :en)
      -3

      iex> Afinn.score_to_words("Terrible product!", :en)
      :negative
  """

  import Language

  @doc """
  Calculates the sentiment score for the given text.

  The function tokenizes the input text, matches words against the AFINN dictionary
  for the specified language, and returns the sum of all sentiment scores.

  ## Parameters

    - `text` - The text to analyze (String)
    - `language` - Language identifier (`:en` for English, `:dk` for Danish, `:fi` for Finnish, `:fr` for French, `:pl` for Polish, `:sv` for Swedish, `:tr` for Turkish, `:emoticon` for Emoticons)

  ## Returns

  An integer representing the sentiment score. Positive values indicate positive sentiment,
  negative values indicate negative sentiment, and zero indicates neutral sentiment.

  ## Examples

      iex> Afinn.score("I love Elixir!", :en)
      3

      iex> Afinn.score("This is bad", :en)
      -3

      iex> Afinn.score("Hello world", :en)
      0
  """
  @spec score(String.t(), :en | :dk | :fi | :fr | :pl | :sv | :tr | :emoticon) :: integer()
  def score(text, language) do
    dictionary = read_dictionaries(language)

    Regex.replace(~r/[!'",.?]/, text, "")
    |> String.downcase()
    |> String.split(" ")
    |> Enum.map(fn x -> Map.get(dictionary, x, 0) end)
    |> Enum.sum()
  end

  @doc """
  Converts the sentiment score to a human-readable classification.

  Classifies the sentiment of the given text as positive, negative, or neutral
  based on the calculated sentiment score.

  ## Parameters

    - `text` - The text to analyze (String)
    - `language` - Language identifier (`:en` for English, `:dk` for Danish, `:fi` for Finnish, `:fr` for French, `:pl` for Polish, `:sv` for Swedish, `:tr` for Turkish, `:emoticon` for Emoticons)

  ## Returns

  An atom representing the sentiment:
    - `:positive` - for scores greater than 1
    - `:negative` - for scores less than -1
    - `:neutral` - for scores between -1 and 1 (inclusive)

  ## Examples

      iex> Afinn.score_to_words("I love this!", :en)
      :positive

      iex> Afinn.score_to_words("I hate this!", :en)
      :negative

      iex> Afinn.score_to_words("This is okay", :en)
      :neutral
  """
  @spec score_to_words(String.t(), :en | :dk | :fi | :fr | :pl | :sv | :tr | :emoticon) ::
          :positive | :negative | :neutral
  def score_to_words(text, language) do
    score = score(text, language)

    cond do
      score > 1 ->
        :positive

      score < -1 ->
        :negative

      score in -1..1 ->
        :neutral
    end
  end
end
