require 'rubygems'
require 'amatch'
require 'colorize'

class Game
	def initialize
		@failures = 0
		@turn = 0
	end

	def pick_choices_for word, words
		others = words.reject{|w| w == word}
		choices = (others.shuffle[0,4] + [word])
		choices.shuffle
	end

	def hit_rate
		rate = 100 - @failures / @turn.to_f * 100
		rate >= 0 ? rate : 0
	end

	def romanize w
		w.gsub("ä", "ae").gsub("ö", "oe").gsub("ü", "ue").gsub("ß", "ss")
	end

	def proximity one, other
		Amatch::Levenshtein.new(romanize(one).downcase).match(romanize(other).downcase)
	end

	def get_an_answer_for correct_answer
		STDOUT.write("> ")
		answer = STDIN.gets.chomp

		while answer != '?' and proximity(answer, correct_answer) > 1
			@failures += 1
			display_definition(answer)
			puts
			puts "Nope. Try again.".red
			puts
			STDOUT.write("> ")
			answer = STDIN.gets.chomp
		end

		answer
	end

	def fetch_definition word
		definitions = `dict "#{word}" 2>/dev/null | grep '     ' | head -2`.chomp.gsub("     ","").split(/[\r\n]/)
		definitions.uniq.join(" -- ")
	end

	def display_definition word
		definition = fetch_definition(word)
		puts "\n#{word.blue} means: #{definition}" if !definition.empty?
	end

	def show_question_for word, sentence, words
		puts
		puts
		puts
		puts "Turn #{@turn}".blue
		puts "#{words.size} words".blue
		color = hit_rate < 75 ? :red : 'green'
		puts "Hit rate: #{'%i' % hit_rate}%".send(color)
		puts "------------------------------------------------------------".blue
		puts
		puts sentence.gsub(/\b#{Regexp.escape(word)}\b/i, "______").strip
		puts 
		puts "Choices: [" + " #{pick_choices_for(word, words).join(" - ")} ".blue + "]"
		puts
	end

	def end_game
		puts
		puts
		puts "#{"Congratulations!".green} Here is a star for you: #{'*'.yellow}"
		puts
	end

	def respond_to_answer answer, correct_answer
		puts
		if answer == '?'
			@failures += 1
			puts "The answer was: #{correct_answer.red}."
			display_definition(correct_answer)
			sleep 2
		elsif proximity(answer, correct_answer) > 0
			puts "Sort of... the answer was: #{correct_answer.yellow}."
			display_definition(correct_answer)
			sleep 1
		else
			puts "Correct! The answer was: #{correct_answer.green}."
			display_definition(correct_answer)
		end
	end

	def play words, &block
		words.shuffle.each{|word|
			@turn += 1

			sentence, correct_answer = yield word
			(puts "Could not find anything to play with for word #{word}."; next) if sentence.nil? or correct_answer.nil?

			show_question_for(correct_answer, sentence, words)
			answer = get_an_answer_for(correct_answer)
			respond_to_answer(answer, correct_answer)

			(end_game; return) if @turn >= words.size and (hit_rate >= 95)
		}

		play(words, &block)
	end
end

