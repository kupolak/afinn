defmodule SwedishTest do
  use ExUnit.Case
  doctest Afinn

  test "creates the correct score for empty string" do
    text = ""
    assert Afinn.score(text, :sv) == 0
    assert Afinn.score_to_words(text, :sv) == :neutral
  end

  test "creates the correct score for Swedish bad word" do
    text = "dålig"
    assert Afinn.score(text, :sv) < 0
    assert Afinn.score_to_words(text, :sv) == :negative
  end

  test "creates the correct score for Swedish words" do
    text = "bra utmärkt"
    assert Afinn.score(text, :sv) > 0
    assert Afinn.score_to_words(text, :sv) == :positive

    text = "dålig produkt!"
    assert Afinn.score(text, :sv) < 0
    assert Afinn.score_to_words(text, :sv) == :negative

    text = "jag älskar det här"
    assert Afinn.score(text, :sv) > 0
    assert Afinn.score_to_words(text, :sv) == :positive

    text = "bra. service kunde vara bättre."
    score = Afinn.score(text, :sv)
    assert score > 0
    assert Afinn.score_to_words(text, :sv) == :positive

    text = "dålig hemskt"
    assert Afinn.score(text, :sv) < 0
    assert Afinn.score_to_words(text, :sv) == :negative

    text = "bra älskar"
    assert Afinn.score(text, :sv) > 0
    assert Afinn.score_to_words(text, :sv) == :positive

    text = "glad älskar"
    assert Afinn.score(text, :sv) > 0
    assert Afinn.score_to_words(text, :sv) == :positive

    text = "dålig slöseri"
    assert Afinn.score(text, :sv) < 0
    assert Afinn.score_to_words(text, :sv) == :negative

    # Realistic negative review
    text =
      "dålig produkt. hemskt service och dålig kvalitet. inte bra. dålig upplevelse. slöseri."

    assert Afinn.score(text, :sv) < 0
    assert Afinn.score_to_words(text, :sv) == :negative

    # Realistic positive review
    text =
      "bra produkt! älskar det här. bra kvalitet och bra service. glad med köpet. bra upplevelse."

    assert Afinn.score(text, :sv) > 0
    assert Afinn.score_to_words(text, :sv) == :positive

    # Mixed sentiment
    text = "bra produkt men dålig pris. älskar kvalitet men hemskt service."
    score = Afinn.score(text, :sv)
    assert is_integer(score)
  end
end
