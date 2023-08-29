require 'test/unit'
require_relative '../lib/player'
require_relative '../lib/hand'

class TestPlayer < Test::Unit::TestCase
  def setup
    @player = Player.new
  end

  def test_player_bank
    assert_equal(100, @player.bank)
  end

  def test_player_bet
    assert_equal(10, @player.bet)
    assert_equal(90, @player.bank)
  end
end
