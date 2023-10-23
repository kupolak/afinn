defmodule DanishTest do
  use ExUnit.Case
  doctest Afinn

  test "creates the correct score for empty string" do
    text = ""
    assert Afinn.score(text, :dk) == 0
    assert Afinn.score_to_words(text, :dk) == :neutral
  end

  test "creates the correct score for Danish bad word" do
    text = "dårligt"
    assert Afinn.score(text, :dk) < 0
    assert Afinn.score_to_words(text, :dk) == :negative
  end

  test "creates the correct score for Danish words" do
    text = "Fantastisk"
    assert Afinn.score(text, :dk) > 0
    assert Afinn.score_to_words(text, :dk) == :positive

    text = "Dårligt produkt!"
    assert Afinn.score(text, :dk) < 0
    assert Afinn.score_to_words(text, :dk) == :negative

    text = "Jeg elsker det her"
    assert Afinn.score(text, :dk) > 0
    assert Afinn.score_to_words(text, :dk) == :positive

    text = "Gennemsnit."
    assert Afinn.score(text, :dk) == 0
    assert Afinn.score_to_words(text, :dk) == :neutral

    text =
      "Moderate priser, udvidet åbningstider, gratis parkering og der er altid fri parkeringsplads."

    assert Afinn.score(text, :dk) == 1
    assert Afinn.score_to_words(text, :dk) == :neutral

    text =
      "Jeg synes det er en god butik med mange gode
      Varer, dog til tider lidt for mange ting og rodde igennem i spot varene.
      Har et par gange osse købt nogen grøntsager der ikke var super friske men jeg kigger mere grundigt nu.
      Generelt mange spændene spot varer hver uge og generelt bredt udvalg.
      Ren butik."

    assert Afinn.score(text, :dk) > 0
    assert Afinn.score_to_words(text, :dk) == :positive

    text =
      "Virkelig fantastisk ret nyt rekreativ område i en gammel grusgrav. :D
      Her kan du fiske, svømme, spille fodbold, cykle på mountainbike på de gode stier,
      gå på opdagelse efter trolde eller måske lave pizza i pizzaovnen. Perfekt til dig der eksempelvis skal på caminoen.
      Er du blevet træt kan du overnatte i en shelter eller bare nyde livet på en bænk eller
      lave mad på en af de mange grillpladser."

    assert Afinn.score(text, :dk) > 0
    assert Afinn.score_to_words(text, :dk) == :positive

    text =
      "Rigtig god skole. Der er et godt sammenhold mellem eleverne og en god dynamik på skolen.
      Det er en skole hvor man udvikler sig personligt samt fagligt og lærerne er meget kompetente til at hjælpe
      de studerende med fremtidige muligheder."

    assert Afinn.score(text, :dk) > 0
    assert Afinn.score_to_words(text, :dk) == :positive

    text =
      "Det var en meget forvirret oplevelse, priserne der var over og under varerne passede
      ikke med varerne omkring, de ansatte i butikken havde mere travlt med at snakke i hørersæt med hinanden,
      om personlige ting, end at betjene kunderne."

    assert Afinn.score(text, :dk) < 0
    assert Afinn.score_to_words(text, :dk) == :negative
  end
end
