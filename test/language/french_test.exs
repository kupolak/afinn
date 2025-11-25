defmodule FrenchTest do
  use ExUnit.Case
  doctest Afinn

  test "creates the correct score for empty string" do
    text = ""
    assert Afinn.score(text, :fr) == 0
    assert Afinn.score_to_words(text, :fr) == :neutral
  end

  test "creates the correct score for French bad word" do
    text = "mauvais"
    assert Afinn.score(text, :fr) < 0
    assert Afinn.score_to_words(text, :fr) == :negative
  end

  test "creates the correct score for French words" do
    text = "excellent"
    assert Afinn.score(text, :fr) > 0
    assert Afinn.score_to_words(text, :fr) == :positive

    text = "mauvais produit!"
    assert Afinn.score(text, :fr) < 0
    assert Afinn.score_to_words(text, :fr) == :negative

    text = "amour et bonheur"
    assert Afinn.score(text, :fr) > 0
    assert Afinn.score_to_words(text, :fr) == :positive

    text = "bon. le service pourrait être meilleur."
    score = Afinn.score(text, :fr)
    assert score > 0
    assert Afinn.score_to_words(text, :fr) == :positive

    text = "horrible terrible mauvais"
    assert Afinn.score(text, :fr) < 0
    assert Afinn.score_to_words(text, :fr) == :negative

    text = "excellent bon"
    assert Afinn.score(text, :fr) > 0
    assert Afinn.score_to_words(text, :fr) == :positive

    text = "amour bonheur"
    assert Afinn.score(text, :fr) > 0
    assert Afinn.score_to_words(text, :fr) == :positive

    text = "mauvais terrible"
    assert Afinn.score(text, :fr) < 0
    assert Afinn.score_to_words(text, :fr) == :negative

    # Realistic negative review
    text =
      "mauvais service. terrible experience. le produit est horrible et mauvais. pas bon du tout. je ne recommande pas."

    assert Afinn.score(text, :fr) < 0
    assert Afinn.score_to_words(text, :fr) == :negative

    # Realistic positive review
    text =
      "excellent service! bon produit et excellent qualite. amour ce restaurant. bonheur total. je recommande."

    assert Afinn.score(text, :fr) > 0
    assert Afinn.score_to_words(text, :fr) == :positive

    # Mixed sentiment
    text = "bon produit mais mauvais prix. excellent qualite mais terrible service."
    score = Afinn.score(text, :fr)
    assert is_integer(score)
  end
end
