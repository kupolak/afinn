defmodule EmoticonTest do
  use ExUnit.Case
  doctest Afinn

  test "creates the correct score for empty string" do
    text = ""
    assert Afinn.score(text, :emoticon) == 0
    assert Afinn.score_to_words(text, :emoticon) == :neutral
  end

  test "creates the correct score for single negative emoticon" do
    text = ":("
    assert Afinn.score(text, :emoticon) < 0
    assert Afinn.score_to_words(text, :emoticon) == :negative
  end

  test "creates the correct score for emoticons" do
    text = ":)"
    assert Afinn.score(text, :emoticon) > 0
    assert Afinn.score_to_words(text, :emoticon) == :positive

    text = ":( bad!"
    assert Afinn.score(text, :emoticon) < 0
    assert Afinn.score_to_words(text, :emoticon) == :negative

    text = ":) :D <3"
    assert Afinn.score(text, :emoticon) > 0
    assert Afinn.score_to_words(text, :emoticon) == :positive

    text = "Average. :-|"
    assert Afinn.score(text, :emoticon) == -1
    assert Afinn.score_to_words(text, :emoticon) == :neutral

    text =
      "This is terrible :( :[ and awful :-( - worst experience ever. So disappointed :'( and frustrated."

    assert Afinn.score(text, :emoticon) < 0
    assert Afinn.score_to_words(text, :emoticon) == :negative

    text =
      "I'm so happy :) :D and satisfied <3! Great quality :-) and amazing service :*. Love it so much! Highly recommend =) :-D"

    assert Afinn.score(text, :emoticon) > 0
    assert Afinn.score_to_words(text, :emoticon) == :positive

    text =
      "We visited this place with family :). Really beautiful and peaceful :] wonderful memories :-) staff were friendly."

    assert Afinn.score(text, :emoticon) > 0
    assert Afinn.score_to_words(text, :emoticon) == :positive

    text =
      "Price is too high and quality bad :-( not satisfied with this purchase :/ disappointment and waste of money :{. Never going back :'("

    assert Afinn.score(text, :emoticon) < 0
    assert Afinn.score_to_words(text, :emoticon) == :negative
  end
end
