require 'test/unit'
require_relative '../lib/card'

class TestCard < Test::Unit::TestCase

  def test_that_king_is_10
    card = Card.new('K', :spade)

    assert_equal(10, card.value)
  end

  def test_that_ace_is_1
    card = Card.new('A', :heart)

    assert_equal(1, card.value)
  end

  def test_face
    assert_equal("K\u{2661}", Card.new('K', :heart).face)
  end
end
