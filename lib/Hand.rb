class Hand
  attr_reader :cards

  BLACK_JACK = 21
  FULL_HAND = 3
  ACE_OPTIONAL_VALUE = 10

  def initialize
    @cards = []
  end

  def value
    return 0 if cards.empty?

    aces, others = cards.partition { |card| card.ace? }

    others_value = others.reduce(0) { |sum, card| sum + card.value }

    if aces.any?
      others_value += aces.size
      others_value += ACE_OPTIONAL_VALUE if others_value <= BLACK_JACK - ACE_OPTIONAL_VALUE
    end

    others_value
  end

  def full?
    size == FULL_HAND
  end

  def bust?
    value > BLACK_JACK
  end

  def size
    cards.size
  end

  def clear
    cards.clear
  end
end
