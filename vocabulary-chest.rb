require 'fileutils.rb'
require 'rubygems'
require 'fast_stemmer'

ROOT_DIR = File.expand_path("~/.vocabulary-chest")
KNOWN_FILE = "#{ROOT_DIR}/known"
UNKNOWN_FILE = "#{ROOT_DIR}/unknown"

FileUtils::mkdir_p(ROOT_DIR)
FileUtils.touch(KNOWN_FILE)
FileUtils.touch(UNKNOWN_FILE)

module VocabularyChest
	@known_file = File.open(KNOWN_FILE,'a')
	@unknown_file = File.open(UNKNOWN_FILE,'a')
	@known_words = nil
	@unknown_words = nil

	at_exit {@known_file.close}
	at_exit {@unknown_file.close}

	def self.known_words
		@known_words ||= File.open(KNOWN_FILE,'r'){|f|f.readlines}.collect{|line| line.chomp}
	end

	def self.unknown_words
		@unknown_words ||= File.open(UNKNOWN_FILE,'r'){|f|f.readlines}.collect{|line| line.chomp}
	end

	def self.add_to_known_words word
		@known_file.puts(sanitize word)
		@known_file.flush
	end

	def self.add_to_unknown_words word
		@unknown_file.puts(sanitize word)
		@unknown_file.flush
	end

	def self.contains? word
		sanitized_word = sanitize word
		known_words.include?(sanitized_word) or unknown_words.include?(sanitized_word)
	end

	def self.is_known? word
		known_words.include?(sanitize(word))
	end

	def self.sanitize word
		word.gsub(/[,\"\.:()?!]/,"").stem.downcase
	end
end

if __FILE__ == $0
	known = VocabularyChest::known_words
	unknown = VocabularyChest::unknown_words
	puts "The chest contains #{known.size} known words."
end
