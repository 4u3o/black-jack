class Game
  def initialize(**args)
    @user = args[:user]
    @dealer = args[:dealer]
    @deck = args[:deck]
    @pot = 0
  end

  def make_bets
    players.each { |player| self.pot += player.bet }
  end

  def deal_hands
    players.each { |player| deck.hit(player) }
  end

  private

  attr_reader :user, :dealer, :deck
  attr_accessor :pot

  def players
    [user, dealer]
  end
end
