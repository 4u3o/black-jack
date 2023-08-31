class Player
  extend Forwardable

  attr_reader :bank, :name
  def_delegators :@hand, :cards, :value, :bust?
  def_delegator :@hand, :full?, :full_hand?
  def_delegator :@hand, :clear, :clear_hand

  BET_SIZE = 10

  def initialize(name='Дилер')
    @bank = 100
    @hand = Hand.new
    @name = name
  end

  def bet
    self.bank -= BET_SIZE
    BET_SIZE
  end

  def win(value)
    self.bank += value
  end

  protected

  attr_writer :bank
end
