require 'minitest/spec'
require 'minitest/autorun'
require_relative './spec_helper'

require_relative '../lib/vocabulary-chest'

describe "Vocabulary Chest" do
  before do
    @chest = VocabularyChest.new
  end

  it "extracts known words from file" do
    @chest.add_to_known_words "a"
    known = @chest.known_words
    known.must_include "a"
  end

  it "extracts unknown words from file" do
    @chest.add_to_unknown_words "b"
    unknown = @chest.unknown_words
    unknown.must_equal ["b"]
  end

  it "checks if a word is known" do
    @chest.add_to_known_words "c"
    @chest.is_known?("c").must_equal true
  end

  it "checks if a word is in the chest" do
    @chest.add_to_known_words "c"
    @chest.contains?("c").must_equal true
  end

  it "stems a word" do
    @chest.stem("counting").must_equal "count"
  end

  it "sanitizes a word" do
    @chest.sanitize(",count()?!").must_equal "count"
  end
end
