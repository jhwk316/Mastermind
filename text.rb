
require_relative 'game'

module Heading
  def intro
    puts
    puts
    puts "*************RULES:************* "
    puts "You must select 4 colors from the color options"
    puts
    puts "**You will have 10 tries to match both the colors and the position of the colors in the secret code"
    puts
    puts "**If you guess the correct color but not the correct position, the display will output the correct guesses in lowercase"
    puts
    puts "**If you guess the correct color AND the correct position of the color, the display will output the correct guess in UPPERCASE"
    puts
    puts "**Colors may appear more than once"
    puts
    puts
  end
end