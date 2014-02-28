require 'minitest/spec'
require 'minitest/autorun'
require_relative './spec_helper'

require_relative '../lib/document-cache'

describe "Document cache" do
  before do
    @cache = DocumentCache.new
  end

  it "clears the cache" do
    @cache.add "a sentence is here"
    @cache.find_examples_for("sentence").must_include "a sentence is here."
    @cache.clear
    @cache.find_examples_for("sentence").size.must_equal 0
  end

  it "adds document to cache" do
    @cache.add "test-doc"
    @cache.find_examples_for("test-doc").must_include "test-doc."
  end

  it "finds examples for a word" do
    @cache.add "come to my aid"
    example = @cache.find_examples_for "aid"
    example.must_equal({"come to my aid." => ["aid"]})
  end

  it "finds matches by grepping" do
    matches = @cache.find_matches_by_grepping "a", ["a","b"]
    matches.must_equal({"a." => ["a"]})
  end

  it "finds matches by stemming" do
    matches = @cache.find_matches_by_stemming "a", ["a","b"]
    matches.must_equal({"a." => ["a"]})
  end
end
