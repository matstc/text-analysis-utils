require_relative './version'

module TAU
  class CLI
    def self.intercept options={}
      if ARGV.include? '--help'
        if options.has_key? :help
          puts options[:help]
          exit 0
        end

        puts "This script is part of a set of utilities for text analysis. For more information, see https://github.com/matstc/text-analysis-utils"
        exit 0
      end

      if ARGV.include? '--version' or ARGV.include? '-v'
        puts "text-analysis-utils v#{TAU::VERSION}"
        exit 0
      end
    end
  end
end
