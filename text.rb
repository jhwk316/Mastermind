# frozen_string_literal: true

require 'yaml'

# RULES TO BE DISPLAYED ON START
module Heading
  def title
    puts '##################################################################################################################################'
  
    puts '     *   *              ****           ****    *********     *******           *    *        *********     *       *   *******'
    puts '    *  *  *            *     *         *           *         *      *         *  *   *           *         * *     *   *      *'
    puts '   *   *   *          * ***** *        ****        *         *******         *   *    *          *         *  *    *   *       *'
    puts '  *         *        *         *          *        *         *    *         *          *         *         *   *   *   *      *'
    puts ' *           *                         ****        *         *     *       *            *    *********     *    *  *   ********'
  
    puts '###################################################################################################################################'
    end

  def intro
    puts
    puts '************* RULES: ************* '
    puts 'You must select 4 colors from the color options'
    puts
    puts '**You will have 10 tries to match both the colors and the position of the
  colors in the secret code'
    puts
    puts '**If you guess the correct color but not the correct position,
  the display will output the correct guesses in lowercase'
    puts
    puts '**If you guess the correct color AND the correct position of the color,
  the display will output the correct guess in UPPERCASE'
    puts
    puts '**Colors may appear more than once'
    puts
  end
end

# OUTPUT AFTER EACH TURN
module Output
  def color_choices
    puts 'Choose 4 of the following: Red, Orange, Yellow, Green, Blue, Purple, White, Black'
  end

  def invalid_choice
    puts
    puts 'YOU DID NOT ENTER VALID CHOICES'
    puts 'PLEASE TRY AGAIN'
    puts
  end

  def wrong_code
    puts "You have #{7 - @attempts} attempts remaining"
    puts "Colors guessed so far: #{@all_guesses.flatten.uniq}"
    puts
    puts "Your clue: #{correct_guesses}"
  end
end

# OUTPUT FOR WHEN THE GAME LOADS FROM A SAVE
module LoadGame
  def load_text
    puts "You have #{7 - @attempts} attempts remaining"
    puts "Colors guessed so far: #{@all_guesses.flatten.uniq}"
    puts "Your last attempt: #{@guess}"
    puts "Your clue: #{@saved_correct_guesses.uniq}"
  end
end
