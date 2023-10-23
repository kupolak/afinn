defmodule Afinn do
  import Language

  def score(text, language) do
    dictionary = read_dictionaries(language)

    Regex.replace(~r/[!'",.?]/, text, "")
    |> String.downcase()
    |> String.split(" ")
    |> Enum.map(fn x -> Map.get(dictionary, x, 0) end)
    |> Enum.sum()
  end

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
