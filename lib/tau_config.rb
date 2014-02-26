require 'fileutils.rb'

module TAUConfig
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

end

FileUtils::mkdir_p TAUConfig.root_dir 
FileUtils::touch TAUConfig.known_file 
FileUtils::touch TAUConfig.unknown_file 
FileUtils::mkdir_p TAUConfig.root_dir 
FileUtils::mkdir_p TAUConfig.cache_dir 
