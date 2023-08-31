class CLI
  def initialize(game)
    @game = game
  end

  def user_turn
    pick(text: user_turns_text, variants: user_turns)
  end

  def next_round?
    pick(text: finish_text, variants: finish_options)
  end

  def show(hand)
    hand.each { |card| card.face}
  end

  def print_out(fase_up=false)
    dealer_cards = cards(game.dealer)
    dealer_cards = hide(dealer_cards) unless fase_up

    user_cards = cards(game.user)

    puts <<~INTERFACE
      -------------------
      Дилер (#{dealer_bank}): #{dealer_cards} << #{fase_up ? dealer_value : '??'}
      На кону: #{pot}
      Вы    (#{user_bank}): #{user_cards} << #{user_value}#{result if fase_up}
    INTERFACE
  end

  private

  attr_accessor :game

  def input(prompt, variants)
    puts prompt

    input = ''
    input = gets.chomp until variants.include? input
    input
  end

  def pick(**args)
    pick = input(args[:text], args[:variants].keys)
    args[:variants][pick]
  end

  def user_bank
    game.user.bank
  end

  def user_value
    game.user.value
  end

  def dealer_bank
    game.dealer.bank
  end

  def dealer_value
    game.dealer.value
  end

  def pot
    game.pot
  end

  def hide(cards)
    cards.gsub(/\|.{2}\|/, '|**|')
  end

  def cards(player)
    player.cards.map { |card| "|#{card.face}|" }.join
  end

  def finish_options
    {
      'y' => true,
      'n' => false
    }
  end

  def user_turns
    {
      's' => :stand,
      'h' => :hit,
      'o' => :open
    }
  end

  def result
    game.draw? ? "\nНичья" : "\nПобедил #{game.winner_name}"
  end

  def finish_text
    <<~END_VARIANTS
      Продолжаем игру?
      -------------------
      y - да
      n - нет
      -------------------
    END_VARIANTS
  end

  def user_turns_text
    <<~TURN_VARIANTS
      -------------------
      s - достаточно
      h - eще
      o - вскрыться
      -------------------
    TURN_VARIANTS
  end
end
