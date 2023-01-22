defmodule Afinn do
  @language_to_filename %{
    :en => "en.txt"
  }

  def score(text, language \\ :en) do
    dictionary = read_dictionaries(language)
      Regex.replace(~r/[!'",.?]/, text, "")
      |> String.downcase
      |> String.split(" ")
      |> Enum.map(fn x -> Map.get(dictionary, x, 0) end)
      |> Enum.sum
  end

  def score_to_words(text) do
    score = score(text)

    cond do
      score > 1 ->
        :positive
      score < -1 ->
        :negative
      score in -1..1 ->
        :neutral
    end
  end

  defp read_dictionaries(language) do
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
