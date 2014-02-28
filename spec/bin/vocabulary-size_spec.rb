require 'minitest/spec'
require 'minitest/autorun'
require_relative '../spec_helper'
require 'tempfile.rb'

describe "vocabulary-size" do

  before do
    @stdout = mock_stdout
    @old_stdout = $stdout
    $stdout = @stdout
  end

  after do
    $stdout = @old_stdout
  end

  it "outputs size of vocabulary" do
    chest = VocabularyChest.new
    chest.add_to_known_words "supercalifragilistigaspillalidocious"
    load './bin/vocabulary-size'
    @stdout.content.must_match /#{chest.known_words.size}/
  end
end
