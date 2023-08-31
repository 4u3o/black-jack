class Game
  attr_reader :user, :dealer, :pot
  attr_accessor :finish

  CARDS_ON_START = 2
  DEALER_CORNER = 17
  BLACK_JACK = 21

  def initialize(**args)
    @user = args[:user]
    @dealer = args[:dealer]
    @deck = args[:deck]
    @pot = 0
    @finish = false
  end

  def make_bets
    players.each { |player| self.pot += player.bet }
  end

  def deal_hands
    players.each { |player| CARDS_ON_START.times { deck.hit(player) } }
  end

  def play_hand(turn)
    self.user_turn = turn

    deck.send(user_turn, user) if user_turn == :hit

    if dealer.value < DEALER_CORNER
      deck.hit(dealer)
    end
  end

  def finish?
    user.bank.zero? || dealer.bank.zero? || finish || !deck.enough?
  end

  def refresh
    clear_hands
    self.user_turn = nil
  end

  def result
    return split_pot if draw?
    pot_to_winner
  end

  def open?
    user_turn == :open || user.full_hand? || dealer.full_hand? || user.bust? || dealer.bust?
  end

  def draw?
    players_bust? || players_draw?
  end

  def winner_name
    winner.name
  end

  private

  attr_reader :deck
  attr_writer :pot
  attr_accessor :user_turn

  def players
    [user, dealer]
  end

  def players_bust?
    players.all? { |player| player.value > BLACK_JACK }
  end

  def players_draw?
    players.first.value == players.last.value
  end

  def winner
    players.filter { |p| p.value <= BLACK_JACK }.max_by { |p| p.value }
  end

  def split_pot
    players.each { |player| player.win(pot / 2) }
    refresh_pot
  end

  def pot_to_winner
    winner.win(pot)
    refresh_pot
  end

  def refresh_pot
    self.pot = 0
  end

  def clear_hands
    players.each { |player| player.clear_hand }
  end
end
