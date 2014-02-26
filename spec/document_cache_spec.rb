require 'minitest/spec'
require 'minitest/autorun'
require_relative './spec_helper'

require_relative '../lib/document-cache'

describe "Document cache" do
  it "adds document to cache" do
    DocumentCache.add "test-doc"
    DocumentCache.find_examples_for("test-doc").must_include "test-doc."
  end

  it "finds examples for a word" do
    DocumentCache.add "come to my aid"
    example = DocumentCache.find_examples_for "aid"
    example.must_equal({"come to my aid." => ["aid"]})
  end

  it "finds matches by grepping" do
    matches = DocumentCache.find_matches_by_grepping "a", ["a","b"]
    matches.must_equal({"a." => ["a"]})
  end

  it "finds matches by stemming" do
    matches = DocumentCache.find_matches_by_stemming "a", ["a","b"]
    matches.must_equal({"a." => ["a"]})
  end
end
