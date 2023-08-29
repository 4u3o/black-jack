class Player
  attr_reader :bank

  BET_SIZE = 10

  def initialize
    @bank = 100
    @hand = Hand.new
  end

  def bet
    self.bank -= BET_SIZE
    BET_SIZE
  end

  private

  attr_writer :bank
end
