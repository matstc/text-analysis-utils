require 'minitest/spec'
require 'minitest/autorun'
require_relative '../spec_helper'
require 'tempfile.rb'

describe "classify-new-words" do

  before do
    @stdout = mock_stdout
    @old_stdout = $stdout
    $stdout = @stdout
  end

  after do
    $stdout = @old_stdout
    ARGV.pop until ARGV.empty?
  end

  it "does not classify known words" do
    file = Tempfile.new 'tau-classify-new-words-spec'
    file.write "i know these words"
    file.close

    chest = VocabularyChest.new
    chest.add_to_known_words "i"
    chest.add_to_known_words "know"
    chest.add_to_known_words "these"
    chest.add_to_known_words "words"

    ARGV[0] = file.path
    load './bin/classify-new-words'
    # returns without asking anything from stdin
  end
end
