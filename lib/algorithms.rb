module Algorithms
  def self.syllable_count word # see https://stackoverflow.com/questions/1271918/ruby-count-syllables
    word.downcase!
    return 1 if word.length <= 3
    word.sub!(/(?:[^laeiouy]es|ed|[^laeiouy]e)$/, '')
    word.sub!(/^y/, '')
    word.scan(/[aeiouy]{1,2}/).size
  end

  def self.wiener_sachtextformel sentences, words, ms
    (0.2656 * (words / sentences) + 0.2744 * ms -1.693).round(2)
  end

  def self.grade sentences, words, syllables
    (0.39 * (words / sentences) + 11.8 * (syllables / words) - 15.59).round(2)
  end
end

