defmodule FinnishTest do
  use ExUnit.Case
  doctest Afinn

  test "creates the correct score for empty string" do
    text = ""
    assert Afinn.score(text, :fi) == 0
    assert Afinn.score_to_words(text, :fi) == :neutral
  end

  test "creates the correct score for Finnish bad word" do
    text = "huono"
    assert Afinn.score(text, :fi) < 0
    assert Afinn.score_to_words(text, :fi) == :negative
  end

  test "creates the correct score for Finnish words" do
    text = "loistava"
    assert Afinn.score(text, :fi) > 0
    assert Afinn.score_to_words(text, :fi) == :positive

    text = "huono tuote!"
    assert Afinn.score(text, :fi) < 0
    assert Afinn.score_to_words(text, :fi) == :negative

    text = "rakastan tätä"
    assert Afinn.score(text, :fi) > 0
    assert Afinn.score_to_words(text, :fi) == :positive

    text = "hyvä. palvelu voisi olla parempi."
    score = Afinn.score(text, :fi)
    assert score >= 0
    assert Afinn.score_to_words(text, :fi) in [:neutral, :positive]

    text = "huono paha"
    assert Afinn.score(text, :fi) < 0
    assert Afinn.score_to_words(text, :fi) == :negative

    text = "loistava hyvä"
    assert Afinn.score(text, :fi) > 0
    assert Afinn.score_to_words(text, :fi) == :positive

    text = "rakastan loistava"
    assert Afinn.score(text, :fi) > 0
    assert Afinn.score_to_words(text, :fi) == :positive

    # Realistic negative review
    text =
      "huono paikka. huono palvelu ja huono ruoka. en suosittele. paha kokemus ja huonot hinnat. ei hyvä."

    assert Afinn.score(text, :fi) < 0
    assert Afinn.score_to_words(text, :fi) == :negative

    # Realistic positive review
    text =
      "loistava paikka! hyvä ruoka ja loistava palvelu. rakastan tätä paikkaa. hyvä kokemus ja hyvä hinta."

    assert Afinn.score(text, :fi) > 0
    assert Afinn.score_to_words(text, :fi) == :positive

    # Mixed sentiment
    text = "hyvä tuote mutta huono hinta. loistava laatu mutta paha palvelu."
    score = Afinn.score(text, :fi)
    assert is_integer(score)
  end
end
