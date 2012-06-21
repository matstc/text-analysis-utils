module Lookup

	def self.fetch_definition word
		definitions = `dict "#{word}" 2>/dev/null | grep '     ' | head -2`.chomp.gsub("     ","").split(/[\r\n]/)
		definitions.uniq.join(" -- ")
	end

	def self.sanitize word
		word.gsub(/[,\.]/,"")
	end

	def self.go words
		words.map{|w| sanitize w}.map{|w| "#{w}\t#{fetch_definition w}"}.join("\n")
	end
end
