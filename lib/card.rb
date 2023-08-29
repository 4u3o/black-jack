class Card
  attr_accessor :rank

  SUITS = {
    spade: "\u{2664}",
    heart: "\u{2661}",
    diamond: "\u{2662}",
    club: "\u{2667}"
  }

  VALUES = {
    'A' => 1, '2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6, '7' => 7, '8' => 8, '9' => 9,
    '10' => 10, 'J' => 10, 'Q' => 10, 'K' => 10
  }

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def value
    VALUES[rank]
  end

  def face
    "#{rank}#{SUITS[suit]}"
  end

  private

  attr_accessor :suit
end
