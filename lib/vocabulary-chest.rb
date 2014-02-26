# encoding: utf-8
require 'fileutils.rb'
require 'rubygems'
require 'lingua/stemmer'

require_relative 'tau_config'

module VocabularyChest
	@known_file = File.open(TAUConfig.known_file,'a')
	@unknown_file = File.open(TAUConfig.unknown_file,'a')
	@stemmer= Lingua::Stemmer.new(:language => ENV['vocabulary_chest_language'] || "en")

	def self.known_words
		File.open(@known_file,'r'){|f|f.readlines}.collect{|line| line.chomp}
	end

	def self.unknown_words
		File.open(@unknown_file,'r'){|f|f.readlines}.collect{|line| line.chomp}
	end

	def self.add_to_known_words word
		@known_file.puts(stem word)
		@known_file.flush
	end

	def self.add_to_unknown_words word
		@unknown_file.puts(stem word)
		@unknown_file.flush
	end

	def self.contains? word
		stemmed_word = stem word
		known_words.include?(stemmed_word) or unknown_words.include?(stemmed_word)
	end

	def self.is_known? word
		known_words.include?(stem(word)) or sanitize(word).empty? or (sanitize(word) =~ /^[-\d]*$/) != nil
	end

	def self.stem word
		@stemmer.stem(sanitize word).downcase
	end

	def self.sanitize word
		word.gsub(/[,\"\.:;()?!„“]/,"")
	end
end
