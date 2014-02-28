require 'minitest/spec'
require 'minitest/autorun'
require_relative '../spec_helper'
require 'tempfile.rb'

describe "percentage-known-of" do

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

  it "lists out known statistics" do
    file = Tempfile.new 'percentage-known-of_spec'
    file.write "spruce fir"
    file.close
    ARGV << file.path

    @chest.add_to_known_words "spruce"
    load './bin/percentage-known-of'
    @stdout.content.must_match /Percentage of words known: 50.00%/
  end
end
