require 'minitest/spec'
require 'minitest/autorun'
require_relative '../spec_helper'
require 'tempfile'

describe "cache-document" do
  after do
    ARGV.pop until ARGV.empty?
  end

  it "adds file content to cache" do
    DocumentCache.new.find_examples_for("text").must_equal({})

    file = Tempfile.new('tau-cache-document-test')
    file.write "text"
    file.close

    ARGV[0] = file.path
    load './bin/cache-document'
    DocumentCache.new.find_examples_for("text").must_equal({"text." => ["text"]})
  end
end
