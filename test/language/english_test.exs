defmodule EnglishTest do
  use ExUnit.Case
  doctest Afinn

  test "creates the correct score for empty string" do
    text = ""
    assert Afinn.score(text, :en) == 0
    assert Afinn.score_to_words(text, :en) == :neutral
  end

  test "creates the correct score for English bad word" do
    text = "bad"
    assert Afinn.score(text, :en) < 0
    assert Afinn.score_to_words(text, :en) == :negative
  end

  test "creates the correct score for English words" do
    text = "Awesome"
    assert Afinn.score(text, :en) > 0
    assert Afinn.score_to_words(text, :en) == :positive

    text = "Bad product!"
    assert Afinn.score(text, :en) < 0
    assert Afinn.score_to_words(text, :en) == :negative

    text = "I love this"
    assert Afinn.score(text, :en) > 0
    assert Afinn.score_to_words(text, :en) == :positive

    text = "Average. Service could be better."
    assert Afinn.score(text, :en) == 1
    assert Afinn.score_to_words(text, :en) == :neutral

    text =
      "If you ever need to contact them it’s the worst and terrible place to call
      - phone not being answered for hours  but when you come in the reception they are sitting and talking
      between each other while phone lines are ringing non stop. Was calling a morning before the appointment
      to confirm the time but because nobody never answered the phone we missed an appointment and when came
      to reception said we can’t disclose information of what time your grandfather’s appointment is. Just ridiculous!"

    assert Afinn.score(text, :en) < 0
    assert Afinn.score_to_words(text, :en) == :negative

    text =
      "I'm a local lad. Raised right next door to this place and Bowling Park so both hold fond
      memories for me and my family. Passed my driving test recently and the first place I wanted to take my missus
      and 1 year old daughter was here. Still wonderful. So fascinating. Got lots of lovely photos of my baby's first visit.
      Staff are lovely, helpful and passionate about the place. Full of interesting trivia and knowledge.
      Made a donation and bought some cute keepsakes from the gift shop.
      Also I'm a descendant of the family who owned it some time ago, so there's that cool fact :)"

    assert Afinn.score(text, :en) > 0
    assert Afinn.score_to_words(text, :en) == :positive

    text =
      "Did a walk here. Such a lovely place with all the walk-through and we went in the church (not for service).
      New building also very nice and old-looking. Beautiful place to be and its all history there"

    assert Afinn.score(text, :en) > 0
    assert Afinn.score_to_words(text, :en) == :positive

    text =
      "This pharmacy is fantastic! Service is brilliant and staff are really friendly and nice.
      I would recommend this pharmacy to anyone if you want fast and efficient service.
      I never have to wait that long for my prescriptions and my medication is always given on time without any issues or concerns."

    assert Afinn.score(text, :en) > 0
    assert Afinn.score_to_words(text, :en) == :positive

    text =
      "I paid £28 for two tickets to see a firework display, what did we get? Well, it was more a laser show/disco sort of thing
      with fireworks in the background and not very good fireworks either. The one pint of beer there was like dishwater,
      it smelled like stale out of date beer and pipe cleaning fluid mixed together, that was another waste of money.
      There was marshalling staff but no one actually doing anything, people were having to ask or wander around not knowing where they're going.
      We were really looking forward to the evening, but after waiting over an hour for any traffic to start moving
      and being in excruciating pain as I am partially disabled and cannot walk very far without rest,
      I shall NEVER go to that event again, a total waste of money, a packet of sparklers and a can of beer
      in the garden would've been a lot better choice. Thinking of going to this event next year? Don't bother, it was utter rubbish!"

    assert Afinn.score(text, :en) < 0
    assert Afinn.score_to_words(text, :en) == :negative
  end
end
