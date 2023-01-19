# frozen_string_literal: false

require 'yaml'
require_relative 'text'

# Begin Class
class Mastermind
  include Heading
  include Output
  include LoadGame

  attr_accessor :attempts, :code, :correct_guesses, :all_guesses, :saved_correct_guesses, :game_saved,
                :guess, :saves, :colors
  attr_reader :valid_guess, :save_response

  def initialize
    title
    intro
    @colors = %w[Red Orange Yellow Green Blue Purple White Black]
    @attempts = 0
    @code = []
    @correct_guesses = []
    @all_guesses = []
    @saved_correct_guesses = []
    @game_saved = ''
    4.times { @code << @colors[rand(0..@colors.length - 1)].upcase }
  end

  def guess_the_code
    color_choices
    guess = gets.chomp.upcase.split
    valid_guess = []
    # display all colors guessed so far
    @all_guesses << guess unless guess.include?('SAVE')
    # Require 4 colors
    guess.select { |el| valid_guess << el if @colors.include?(el.capitalize) }
    # Match guess with secret code
    guess.each_with_index do |el, idx|
      if code.each_with_index.any? { |element, index| element == el && index == idx }
        correct_guesses << el
        saved_correct_guesses << el
      elsif code.any? { |element| element == el && idx != element }
        correct_guesses << el.downcase
        saved_correct_guesses << el.downcase
      end
    end
    if correct_guesses != code
      save_game if guess.include?('SAVE')
      unless guess.include?('SAVE')
        @attempts += 1 unless valid_guess.length != 4
        wrong_code
        puts "Your last attempt: #{guess.join(' ')}"
        @correct_guesses = [] unless guess.length < 4 # resets the checker
        if valid_guess.length != 4
          new_game if guess.include?('SAVE')
          invalid_choice unless game_saved == 'saved'
          guess_the_code unless game_saved == 'saved'
        end
      end
    end
  end

  def new_game
    guess_the_code until correct_guesses == code || attempts == 7 || game_saved == 'saved'
    puts
    puts "SORRY! YOU LOSE! THE SECRET CODE WAS #{code}" if @attempts == 7
    puts
    puts 'CONGRATULATIONS!!  YOU WIN' if correct_guesses == code
    puts
  end

  def save_game
    puts 'Do you wish to save your game? [Y/N]'
    save_response = gets.chomp.downcase
    if save_response == 'y'
      Dir.mkdir('game_saves') unless Dir.exist?('game_saves')
      File.open('game_saves/mastermind.yml', 'w') { |file| file.write(YAML.dump(self)) }
      game_saved << 'saved'
      puts 'Your game has been saved'
    else
      guess_the_code
    end
  end

  def load_game
    if File.exist?('game_saves/mastermind.yml')
      puts 'Do you wish to load from a save? [Y/N]'
      response = gets.chomp.upcase
      case response
      when 'Y'
        file = YAML.safe_load(File.read('game_saves/mastermind.yml'), permitted_classes: [Mastermind])
        @code = file.code
        @saved_correct_guesses = file.saved_correct_guesses.uniq
        @all_guesses = file.all_guesses
        @attempts = file.attempts
        @game_saved = file.game_saved
        load_text
        new_game
        @game_saved = ''
      when 'N'
        File.delete('./game_saves/mastermind.yml')
        new_game
      else
        load_game
      end
    else
      new_game
    end
  end
  # END LOAD_GAME
end
# END CLASS
