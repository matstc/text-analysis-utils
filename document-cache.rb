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

	def self.documents
		Dir["#{CACHE_DIR}/*"]
	end

	def self.find_examples_for search, count=1
		find_matches_in documents, search, count
	end

	def self.clean(sentence)
		sentence.strip + "."
	end

	def self.extract_matching_words search, sentence
		matches = find_matches_by_stemming(search, [sentence])
		return matches.values.first if !matches.empty?
		return find_matches_by_grepping(search, [sentence]).values.first
	end

	def self.frequency_list
		text = ""
		documents.each{|f| text += File.open(f).read }
		stems = text.split(" ").map{|w| VocabularyChest::stem(w)}
		counts = stems.inject(Hash.new(0)) {|h,stem| h[stem] += 1; h }
		counts.reject!{|stem, count| count < 2}
		counts.sort_by {|k,v| v}.reverse
	end
end

if __FILE__ == $0
	puts "The document cache contains #{DocumentCache.documents.size} documents."
	puts "Here are the 10 most frequent stems:"
	DocumentCache.frequency_list[0,10].each{|stem, count| puts "#{count} #{stem}"}
end
