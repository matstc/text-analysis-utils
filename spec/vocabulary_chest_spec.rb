require 'minitest/spec'
require 'minitest/autorun'
require_relative './spec_helper'

require_relative '../lib/vocabulary-chest'

describe "Vocabulary Chest" do
  it "extracts known words from file" do
    VocabularyChest::add_to_known_words "a"
    known = VocabularyChest::known_words
    known.must_include "a"
  end

  it "extracts unknown words from file" do
    VocabularyChest::add_to_unknown_words "b"
    unknown = VocabularyChest::unknown_words
    unknown.must_equal ["b"]
  end

  it "checks if a word is known" do
    VocabularyChest::add_to_known_words "c"
    VocabularyChest::is_known?("c").must_equal true
  end

  it "checks if a word is in the chest" do
    VocabularyChest::add_to_known_words "c"
    VocabularyChest::contains?("c").must_equal true
  end
end
