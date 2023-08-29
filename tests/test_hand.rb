require 'test/unit'
require_relative '../lib/card'
require_relative '../lib/hand'

class TestHand < Test::Unit::TestCase
  def test_hand_value
    hand = Hand.new
    hand.cards << Card.new('K', :club)
    hand.cards << Card.new('A', :spade)

    assert_equal(21, hand.value)
    assert_false(hand.bust?)
  end

  def test_hand_with_2_aces
    hand = Hand.new
    hand.cards << Card.new('A', :club)
    hand.cards << Card.new('A', :spade)
    hand.cards << Card.new('4', :club)

    assert_equal(16, hand.value)
  end

  def test_A6J_hand
    hand = Hand.new
    hand.cards << Card.new('6', :club)
    hand.cards << Card.new('A', :spade)
    hand.cards << Card.new('J', :diamond)

    assert_equal(17, hand.value)
  end

  def test_bust_hand
    hand = Hand.new
    hand.cards << Card.new('6', :club)
    hand.cards << Card.new('J', :diamond)
    hand.cards << Card.new('6', :spade)

    assert_equal(22, hand.value)
    assert_true(hand.bust?)
  end
end
