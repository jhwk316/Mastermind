require 'yaml'
require_relative 'text.rb'


class Mastermind
  include Heading
  include Output

  @@colors = ["Red", "Orange", "Yellow", "Green", "Blue", "Purple", "White", "Black"]
  #attr_accessor :guess, :valid_guess, :saves

  attr_accessor :attempts, :code, :correct_guesses, :all_guesses, :saved_correct_guesses, :game_saved
  def initialize
    intro
    @attempts = 0
    @code = []
    @correct_guesses = []
    @all_guesses = []
    @saved_correct_guesses = []
    @game_saved = ""
    4.times {@code << @@colors[rand(0..@@colors.length - 1)].upcase}
  end #END INITIALIZE

  attr_accessor :guess
  attr_reader :valid_guess
  def guess_the_code
    color_choices
    guess = gets.chomp.upcase.split
    #save_game if guess.include?('SAVE')
    valid_guess = []
    #display all colors guessed so far
    @all_guesses << guess unless guess.include?('SAVE')

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

    end #END EACH_WITH_INDEX

    if correct_guesses != code
        if guess.include?('SAVE')
           save_game
         end
        puts
      unless guess.include?('SAVE')
        @attempts += 1 unless valid_guess.length != 4
        puts "You have #{7 - @attempts} attempts remaining"
        puts "Colors guessed so far: #{@all_guesses.flatten.uniq}" #unless guess.include?('SAVE')
        puts
        puts "Your last attempt: #{guess}" #unless guess.include?('SAVE')
        puts
        puts "Your clue: #{correct_guesses}" #unless guess.include?('SAVE')
        @correct_guesses = [] unless guess.length < 4  #resets the checker so the old guesses aren't stored with the new guesses
      end
    end

    if valid_guess.length != 4
        new_game if guess.include?('SAVE')
        invalid_choice unless game_saved == 'saved'
        guess_the_code unless game_saved == 'saved'
    end
  end #END GUESS_THE_CODE

    def new_game
         guess_the_code until correct_guesses == code || attempts == 7 || game_saved == 'saved'
            puts
            puts "SORRY! YOU LOSE! THE SECRET CODE WAS #{code}" if @attempts == 7
            puts
            puts "CONGRATULATIONS!!  YOU WIN" if correct_guesses == code
            puts
    end #END NEW_GAME

    attr_reader :save_response
    def save_game
      puts "Do you wish to save your game? [Y/N]"
      save_response = gets.chomp.downcase
        if save_response == 'y'
          Dir.mkdir('game_saves') unless Dir.exists?('game_saves')
          File.open('game_saves/mastermind.yml', 'w') {|file| file.write(YAML.dump(self))}
          game_saved << 'saved'
          puts "Your game has been saved"
        else
          guess_the_code
        end
    end #END SAVE_GAME

    def load_game
      if File.exists?('game_saves/mastermind.yml')
        puts "Do you wish to load from a save? [Y/N]"
        response = gets.chomp.upcase
        if response == 'Y'
          file = YAML.safe_load(File.read('game_saves/mastermind.yml'), permitted_classes: [Mastermind])
          @code = file.code
          @saved_correct_guesses = file.saved_correct_guesses.uniq
          #@saved_last_guess = file.saved_last_guess
          #@correct_guesses = file.correct_guesses
          @all_guesses = file.all_guesses
          @attempts = file.attempts
          @game_saved = file.game_saved
          puts "You have #{7 - @attempts} attempts remaining"
          puts "Colors guessed so far: #{@all_guesses.flatten.uniq}"
          puts
          puts "Your last attempt: #{@guess}"
          puts
          puts "Your clue: #{@saved_correct_guesses.uniq}"
          new_game
          @game_saved = ""
        elsif response == 'N'
          File.delete('./game_saves/mastermind.yml')
          new_game
        else
          load_game
        end
      else
        new_game
      end
    end #END LOAD_GAME
end #END CLASS

