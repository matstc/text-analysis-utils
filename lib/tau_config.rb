require 'fileutils.rb'

module TAUConfig
  def self.language
    language = File.open(language_file,'r') { |f| f.read }
    return language unless language.empty?

    ENV['vocabulary_chest_language'] || "en"
  end

  def self.language= language
    File.open(language_file,'w') do |f|
      f.write language
    end
  end

  def self.root_dir
    File.expand_path(ENV['vocabulary_chest_location'] || "~/.vocabulary-chest")
  end

  def self.known_file
    "#{root_dir}/known"
  end

  def self.unknown_file
    "#{root_dir}/unknown"
  end

  def self.cache_dir
    "#{root_dir}/docs"
  end

  def self.language_file
    "#{root_dir}/language"
  end
end

FileUtils::mkdir_p TAUConfig.root_dir 
FileUtils::touch TAUConfig.language_file
FileUtils::touch TAUConfig.known_file 
FileUtils::touch TAUConfig.unknown_file 
FileUtils::mkdir_p TAUConfig.root_dir 
FileUtils::mkdir_p TAUConfig.cache_dir 
