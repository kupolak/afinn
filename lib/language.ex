defmodule Language do
  @language_to_filename %{
    :en => "en.txt"
  }

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
