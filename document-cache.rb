require 'fileutils.rb'
require 'rubygems'
require 'uuid'

require File.join(File.dirname(__FILE__), 'vocabulary-chest' )

CACHE_DIR = "#{ROOT_DIR}/docs"

FileUtils::mkdir_p(ROOT_DIR)
FileUtils::mkdir_p(CACHE_DIR)

module DocumentCache
	def self.add text
		filename = "#{CACHE_DIR}/#{UUID.new.generate}"
		File.open(filename,'w'){|f| f.write(text)}
	end

	def self.find_examples_for text, count=1
		matches = []
		filenames = Dir["#{CACHE_DIR}/*"]
		filenames.each {|filename|
			File.open(filename){|file|
				contents = file.read
				sentences = contents.split(/[\.?!\n]/)
				token = VocabularyChest::stem(text)
				matches += sentences.select{|s| (s =~ /\b#{Regexp.escape(token)}/i) != nil }

				matches = matches[0,count] if matches.size > count
				return clean(matches) if matches.size == count
			}
		}
		clean(matches)
	end

	def self.clean(matches)
		matches.map{|m| m + "."}
	end
end
