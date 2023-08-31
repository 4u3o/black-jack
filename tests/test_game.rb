require_relative 'test_helper'

class TestGame < Test::Unit::TestCase
  def setup
    @user = Player.new('test')
    @dealer = Player.new
    @game = Game.new(
      user: @user,
      dealer: @dealer,
      deck: Deck.new.shuffle!
    )
  end

  def test_that_game_makes_bets
    @game.make_bets

    assert_equal(20, @game.pot)
    assert_equal(90, @user.bank)
    assert_equal(90, @dealer.bank)
  end

  def test_that_game_deal_hands
    @game.deal_hands

    assert_equal(2, @user.cards.size)
    assert_equal(2, @dealer.cards.size)
  end

  def test_that_game_plays_hand
    @game.deal_hands
    @game.play_hand(:hit)

    assert_equal(3, @user.cards.size)
    if @dealer.value < 17
      assert_equal(3, @dealer.cards.size)
    end
  end

  def test_that_game_refreshes
    @game.make_bets
    @game.deal_hands
    @game.play_hand(:hit)
    @game.refresh

    assert_equal([], @user.cards)
    assert_equal([], @dealer.cards)
  end

  def test_result_with_draw
    user_cards = [Card.new('A', :club), Card.new('8', :club)]
    dealer_cards = [Card.new('A', :heart), Card.new('8', :heart)]
    @game.make_bets
    @user.cards.concat(user_cards)
    @dealer.cards.concat(dealer_cards)
    @game.play_hand(:open)

    assert_true(@game.draw?)

    @game.result

    assert_equal(@user.bank, @dealer.bank)
  end

  def test_result_with_dealer_win
    user_cards = [Card.new('A', :club), Card.new('8', :club)]
    dealer_cards = [Card.new('A', :heart), Card.new('9', :heart)]
    @game.make_bets
    @user.cards.concat(user_cards)
    @dealer.cards.concat(dealer_cards)
    @game.play_hand(:open)

    assert_false(@game.draw?)

    @game.result

    assert_equal(110, @dealer.bank)
  end
end
