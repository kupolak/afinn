defmodule PolishTest do
  use ExUnit.Case
  doctest Afinn

  test "creates the correct score for empty string" do
    text = ""
    assert Afinn.score(text, :pl) == 0
    assert Afinn.score_to_words(text, :pl) == :neutral
  end

  test "creates the correct score for Polish bad word" do
    text = "zły"
    assert Afinn.score(text, :pl) < 0
    assert Afinn.score_to_words(text, :pl) == :negative
  end

  test "creates the correct score for Polish words" do
    text = "doskonały"
    assert Afinn.score(text, :pl) > 0
    assert Afinn.score_to_words(text, :pl) == :positive

    text = "zły produkt!"
    assert Afinn.score(text, :pl) < 0
    assert Afinn.score_to_words(text, :pl) == :negative

    text = "wspaniały produkt"
    assert Afinn.score(text, :pl) > 0
    assert Afinn.score_to_words(text, :pl) == :positive

    text = "dobry. obsługa mogłaby być lepsza."
    score = Afinn.score(text, :pl)
    assert score > 0
    assert Afinn.score_to_words(text, :pl) == :positive

    text = "to jest okropne i złe. nie polecam"
    assert Afinn.score(text, :pl) < 0
    assert Afinn.score_to_words(text, :pl) == :negative

    text = "wspaniały doskonały dobry"
    assert Afinn.score(text, :pl) > 0
    assert Afinn.score_to_words(text, :pl) == :positive

    text = "szczęśliwy wspaniały"
    assert Afinn.score(text, :pl) > 0
    assert Afinn.score_to_words(text, :pl) == :positive

    text = "zły okropny"
    assert Afinn.score(text, :pl) < 0
    assert Afinn.score_to_words(text, :pl) == :negative

    # Realistic negative review
    text =
      "zły produkt. okropna obsługa i zła jakość. nie polecam. złe doświadczenie. huono."

    assert Afinn.score(text, :pl) < 0
    assert Afinn.score_to_words(text, :pl) == :negative

    # Realistic positive review
    text =
      "wspaniały produkt! doskonała jakość i dobry serwis. szczęśliwy z zakupu. wspaniałe doświadczenie. polecam."

    assert Afinn.score(text, :pl) > 0
    assert Afinn.score_to_words(text, :pl) == :positive

    # Mixed sentiment
    text = "dobry produkt ale zła cena. wspaniała jakość ale okropna obsługa."
    score = Afinn.score(text, :pl)
    assert is_integer(score)
  end
end
