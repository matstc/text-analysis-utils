require 'minitest/spec'
require 'minitest/autorun'
require_relative '../spec_helper'
require 'tempfile.rb'

describe "readability-of" do

  before do
    @stdout = mock_stdout
    @old_stdout = $stdout
    $stdout = @stdout

    @chest = VocabularyChest.new
  end

  after do
    $stdout = @old_stdout
    ARGV.pop until ARGV.empty?
  end

  it "outputs readability statistics" do
    file = Tempfile.new 'percentage-known-of_spec'
    file.write "The wallet is in my pocket."
    file.close
    ARGV << file.path

    load './bin/readability-of'
    @stdout.content.must_match /Flesch–Kincaid Grade Level: 2.48/
  end
end
