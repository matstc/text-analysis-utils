require 'fileutils.rb'

ENV['vocabulary_chest_location'] = "/tmp/vocabulary-chest-tests"
FileUtils::rm_rf ENV['vocabulary_chest_location']
FileUtils::mkdir ENV['vocabulary_chest_location']
