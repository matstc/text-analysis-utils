require 'minitest/spec'
require 'minitest/autorun'
require_relative '../spec_helper'

describe "find-examples-for" do
  before do
    @stdout = mock_stdout
    @old_stdout = $stdout
    $stdout = @stdout

    @cache = DocumentCache.new
    @cache.clear
  end

  after do
    $stdout = @old_stdout
    ARGV.pop until ARGV.empty?
  end

  it "finds examples for word in argument" do
    @cache.add "the lion is king"

    ARGV[0] = "lion"
    load './bin/find-examples-for'
    @stdout.content.must_match /the .*lion.* is king./
  end

  it "serves two examples" do
    @cache.add "the lion is king"
    @cache.add "the lion is strong"
    @cache.add "the lion is awesome"

    ARGV[0] = "--3"
    ARGV[1] = "lion"
    load './bin/find-examples-for'
    @stdout.content.split("\n").length.must_equal 3
  end
end
