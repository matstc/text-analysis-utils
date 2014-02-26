require 'fileutils.rb'
require 'uuid'

require_relative 'tau_config'
require_relative 'vocabulary-chest'

module DocumentCache
	def self.add document
		filename = "#{TAUConfig::cache_dir}/#{UUID.new.generate}"
		File.open(filename,'w'){|f| f.write(document)}
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
		Dir["#{TAUConfig::cache_dir}/*"]
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
		counts = text.split(" ").inject(Hash.new(0)) {|h,w| h[w] += 1; h }
		counts.reject!{|word, count| count < 2}
		counts.sort_by {|k,v| v}.reverse
	end

	def self.stemmed_frequency_list
		text = ""
		documents.each{|f| text += File.open(f).read }
		stems = text.split(" ").map{|w| VocabularyChest::stem(w)}
		counts = stems.inject(Hash.new(0)) {|h,stem| h[stem] += 1; h }
		counts.reject!{|stem, count| count < 2}
		counts.sort_by {|k,v| v}.reverse
	end
end
