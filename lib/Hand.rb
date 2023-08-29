class Hand
  attr_reader :cards

  BLACK_JACK = 21

  def initialize
    @cards = []
  end

  def value
    return 0 if cards.empty?

    aces, others = cards.partition { |card| card.ace? }

    others_value = others.reduce(0) { |sum, card| sum + card.value }

    if aces.any?
      others_value += aces.size
      others_value += 10 if others_value <= 11
    end

    others_value
  end

  def bust?
    value > BLACK_JACK
  end
end
