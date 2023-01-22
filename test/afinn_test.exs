defmodule AfinnTest do
  use ExUnit.Case
  doctest Afinn

  test "creates the correct score for empty string" do
    text = ""
    assert Afinn.score(text) == 0
    assert Afinn.score_to_words(text) == :neutral
  end

  test "creates the correct score for English bad word" do
    text = "bad"
    assert Afinn.score(text) < 0
    assert Afinn.score_to_words(text) == :negative
  end

  test "creates the correct score for English words" do
    text = "Awesome"
    assert Afinn.score(text) > 0
    assert Afinn.score_to_words(text) == :positive

    text = "Bad product!"
    assert Afinn.score(text) < 0
    assert Afinn.score_to_words(text) == :negative

    text = "I love this"
    assert Afinn.score(text) > 0
    assert Afinn.score_to_words(text) == :positive

    text = "Average. Service could be better."
    assert Afinn.score(text) == 1
    assert Afinn.score_to_words(text) == :neutral

    text = "If you ever need to contact them it’s the worst and terrible place to call
      - phone not being answered for hours  but when you come in the reception they are sitting and talking
      between each other while phone lines are ringing non stop. Was calling a morning before the appointment
      to confirm the time but because nobody never answered the phone we missed an appointment and when came
      to reception said we can’t disclose information of what time your grandfather’s appointment is. Just ridiculous!"
    assert Afinn.score(text) < 0
    assert Afinn.score_to_words(text) == :negative

    text = "I'm a local lad. Raised right next door to this place and Bowling Park so both hold fond
      memories for me and my family. Passed my driving test recently and the first place I wanted to take my missus
      and 1 year old daughter was here. Still wonderful. So fascinating. Got lots of lovely photos of my baby's first visit.
      Staff are lovely, helpful and passionate about the place. Full of interesting trivia and knowledge.
      Made a donation and bought some cute keepsakes from the gift shop.
      Also I'm a descendant of the family who owned it some time ago, so there's that cool fact :)"
    assert Afinn.score(text) > 0
    assert Afinn.score_to_words(text) == :positive
  end
end
