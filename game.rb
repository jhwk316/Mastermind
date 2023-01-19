
require_relative 'display_text.rb'


class Mastermind
  include Heading
  include Output

  @@colors = ["Red", "Orange", "Yellow", "Green", "Blue", "Purple", "White", "Black"]

  attr_accessor :attempts, :code, :correct_guesses, :all_guesses
  attr_reader :valid_guess
  def initialize
    intro
    @attempts = 0
    @code = []
    @correct_guesses = []
    @all_guesses = []
    @game_saved = ""
    4.times {@code << @@colors[rand(0..@@colors.length - 1)].upcase}
  end #END INITIALIZE

    def guess_the_code

        guess = gets.chomp.upcase.split
        #save_game if guess.include?('SAVE')
        valid_guess = []
        #display all colors guessed so far
        @all_guesses << guess

      ## Require 4 colors
        guess.select do |el|
          valid_guess << el if @@colors.include?(el.capitalize)
        end
        #Match guess with secret code
        guess.each_with_index do |el, idx|
          if  code.each_with_index.any? {|element, index| element == el && index == idx }
            correct_guesses << el
            saved_correct_guesses << el
          elsif code.any? {|element| element == el && idx != element}
            correct_guesses << el.downcase
            saved_correct_guesses << el.downcase
          end

        end #END EACH_WITH_INDEX    color_choices
          guess = gets.chomp.upcase.split
          #save_game if guess.include?('SAVE')
          valid_guess = []
          #display all colors guessed so far
          @all_guesses << guess

    if correct_guesses != code
        puts
        
              @attempts += 1 unless valid_guess.length != 4
            puts "You have #{7 - @attempts} attempts remaining"
            puts "Colors guessed so far: #{@all_guesses.flatten.uniq}" #unless guess.include?('SAVE')
            puts
            puts "Your last attempt: #{guess}" #unless guess.include?('SAVE')
            puts
            puts "Your clue: #{correct_guesses}" #unless guess.include?('SAVE')
              @correct_guesses = [] unless guess.length < 4  #resets the checker so the old guesses aren't stored with the new guesses
          
    end
  end #END GUESS_THE_CODE






end #END CLASS

