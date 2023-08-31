require 'forwardable'
require_relative 'lib/card'
require_relative 'lib/hand'
require_relative 'lib/deck'
require_relative 'lib/player'
require_relative 'lib/game'
require_relative 'lib/cli'

puts 'Введите свое имя'
name = ''
name = gets.chomp.capitalize while name == ''

game = Game.new(
  user: Player.new(name),
  dealer: Player.new,
  deck: Deck.new.shuffle!
)

cli = CLI.new(game)

until game.finish?
  game.make_bets
  game.deal_hands
  until game.open?
    cli.print_out
    game.play_hand(cli.user_turn)
  end
  game.result
  cli.print_out(fase_up = true)
  game.refresh
  game.finish = !cli.next_round?
end
