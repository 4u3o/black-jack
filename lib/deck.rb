class Deck
  MIN_CARDS_FOR_PLAY = 6

  def cards
    @cards ||= ('2'..'10').to_a.concat(['J', 'Q', 'K', 'A']).map do |rank|
      [:club, :diamond, :heart, :spade].map { |suit| [rank, suit] }
    end.flatten(1).map { |rank, suit| Card.new(rank, suit) }
  end

  def shuffle!
     cards.shuffle!
     self
  end

  def hit(player)
    player.cards << cards.pop
  end

  def enough?
    cards.size >= MIN_CARDS_FOR_PLAY
  end

  private

  def pop
    cards.pop
  end
end
