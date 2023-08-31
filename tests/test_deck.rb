require_relative 'test_helper'

class TestDeck < Test::Unit::TestCase
  def setup
    @deck = Deck.new
  end

  def test_that_deck_creates
    expected = [
      "2♧", "2♢", "2♡", "2♤",
      "3♧", "3♢", "3♡", "3♤",
      "4♧", "4♢", "4♡", "4♤",
      "5♧", "5♢", "5♡", "5♤",
      "6♧", "6♢", "6♡", "6♤",
      "7♧", "7♢", "7♡", "7♤",
      "8♧", "8♢", "8♡", "8♤",
      "9♧", "9♢", "9♡", "9♤",
      "10♧", "10♢", "10♡", "10♤",
      "J♧", "J♢", "J♡", "J♤",
      "Q♧", "Q♢", "Q♡", "Q♤",
      "K♧", "K♢", "K♡", "K♤",
      "A♧", "A♢", "A♡", "A♤"
    ]

    assert_equal(expected, @deck.cards.map(&:face))
  end

  def test_that_deck_shuffles
    before = @deck.cards.dup

    @deck.shuffle!

    assert_not_equal(before, @deck.cards)
  end

  def test_that_deck_pops_a_card
    before = @deck.cards.size

    @deck.send(:pop)

    assert_not_equal(before, @deck.cards.size)
    assert_equal(before, @deck.cards.size + 1)
  end
end
