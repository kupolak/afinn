defmodule TurkishTest do
  use ExUnit.Case
  doctest Afinn

  test "creates the correct score for empty string" do
    text = ""
    assert Afinn.score(text, :tr) == 0
    assert Afinn.score_to_words(text, :tr) == :neutral
  end

  test "creates the correct score for Turkish bad word" do
    text = "kötü"
    assert Afinn.score(text, :tr) < 0
    assert Afinn.score_to_words(text, :tr) == :negative
  end

  test "creates the correct score for Turkish words" do
    text = "mükemmel"
    assert Afinn.score(text, :tr) > 0
    assert Afinn.score_to_words(text, :tr) == :positive

    text = "kötü ürün!"
    assert Afinn.score(text, :tr) < 0
    assert Afinn.score_to_words(text, :tr) == :negative

    text = "güzel harika"
    assert Afinn.score(text, :tr) > 0
    assert Afinn.score_to_words(text, :tr) == :positive

    text = "iyi. hizmet daha iyi olabilir."
    score = Afinn.score(text, :tr)
    assert score > 0
    assert Afinn.score_to_words(text, :tr) == :positive

    text = "kötü berbat"
    assert Afinn.score(text, :tr) < 0
    assert Afinn.score_to_words(text, :tr) == :negative

    text = "harika güzel"
    assert Afinn.score(text, :tr) > 0
    assert Afinn.score_to_words(text, :tr) == :positive

    text = "mükemmel harika"
    assert Afinn.score(text, :tr) > 0
    assert Afinn.score_to_words(text, :tr) == :positive

    text = "kötü berbat"
    assert Afinn.score(text, :tr) < 0
    assert Afinn.score_to_words(text, :tr) == :negative

    # Realistic negative review
    text = "kötü ürün. berbat hizmet ve kötü kalite. iyi değil. kötü deneyim. tavsiye etmem."

    assert Afinn.score(text, :tr) < 0
    assert Afinn.score_to_words(text, :tr) == :negative

    # Realistic positive review
    text =
      "harika ürün! mükemmel kalite ve güzel hizmet. iyi alışveriş. harika deneyim. tavsiye ederim."

    assert Afinn.score(text, :tr) > 0
    assert Afinn.score_to_words(text, :tr) == :positive

    # Mixed sentiment
    text = "güzel ürün ama kötü fiyat. harika kalite ama berbat hizmet."
    score = Afinn.score(text, :tr)
    assert is_integer(score)
  end
end
