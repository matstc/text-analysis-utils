require 'fileutils.rb'

ENV['vocabulary_chest_location'] = "/tmp/vocabulary-chest-tests"
FileUtils::rm_rf ENV['vocabulary_chest_location']
FileUtils::mkdir ENV['vocabulary_chest_location']

def mock_stdout
  Class.new do
    attr_reader :content

    def initialize
      @content = ""
    end

    def write s
      @content += s
    end

    def flush
    end

    def puts s=""
      @content += s
      @content += "\n"
    end
  end.new
end
