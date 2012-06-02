require 'fileutils.rb'
require 'rubygems'
require 'uuid'

ROOT_DIR = File.expand_path("~/.vocabulary-chest")
CACHE_DIR = "#{ROOT_DIR}/docs"

FileUtils::mkdir_p(ROOT_DIR)
FileUtils::mkdir_p(CACHE_DIR)

module DocumentCache
	def self.add text
		filename = "#{CACHE_DIR}/#{UUID.new.generate}"
		File.open(filename,'w'){|f| f.write(text)}
	end

	def self.find_examples_for text, count=1, hide_match=false
		matches = []
		filenames = Dir["#{CACHE_DIR}/*"]
		filenames.each {|filename|
			File.open(filename){|file|
				contents = file.read
				sentences = contents.split(".")
				matches += sentences.select{|s| s.include? text}

				matches = matches[0,count] if matches.size > count
				matches.map!{|match| match.gsub(text, "___")} if hide_match
				return matches if matches.size == count
			}
		}
		nil
	end
end
