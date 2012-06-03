require 'fileutils.rb'
require 'rubygems'
require 'uuid'

require File.join(File.dirname(__FILE__), 'vocabulary-chest' )

CACHE_DIR = "#{ROOT_DIR}/docs"

FileUtils::mkdir_p(ROOT_DIR)
FileUtils::mkdir_p(CACHE_DIR)

module DocumentCache
	def self.add search
		filename = "#{CACHE_DIR}/#{UUID.new.generate}"
		File.open(filename,'w'){|f| f.write(search)}
	end

	def self.find_matches_by_stemming search, sentences
		token = VocabularyChest::stem(search)
		sentences.inject({}){|hash, s| 
			words = s.split(" ")
			found = words.select{|w| VocabularyChest::stem(w) == token}
			hash[clean(s)] = found.map{|f| VocabularyChest::sanitize(f)} if !found.empty?
			hash
		}
	end

	def self.find_matches_by_grepping search, sentences
		sentences.inject({}){|hash, s| 
			hash[clean(s)] = [search] if s.include? search 
			hash
		}
	end

	def self.find_matches_in filenames, search, count
		matches = {}

		[:find_matches_by_stemming, :find_matches_by_grepping].each{|matcher|
			filenames.each {|filename|
				File.open(filename){|file|
					contents = file.read
					sentences = contents.split(/[\.?!\n]/)
					matches.merge!(self.send(matcher, search, sentences))

					matches.shift until matches.size <= count if matches.size > count
					return matches if matches.size == count
				}
			}
		}

		matches
	end

	def self.find_examples_for search, count=1
		filenames = Dir["#{CACHE_DIR}/*"]
		find_matches_in filenames, search, count
	end

	def self.clean(sentence)
		sentence.strip + "."
	end

	def self.extract_matching_words search, sentence
		matches = find_matches_by_stemming(search, [sentence])
		return matches.values.first if !matches.empty?
		return find_matches_by_grepping(search, [sentence]).values.first
	end

end
