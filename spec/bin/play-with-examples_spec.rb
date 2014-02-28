require 'minitest/spec'
require 'minitest/autorun'
require_relative '../spec_helper'
require_relative '../../lib/document-cache'
require 'tempfile.rb'

describe "play-with-examples" do

  before do
    @stdout = mock_stdout
    @old_stdout = $stdout
    $stdout = @stdout
  end

  after do
    $stdout = @old_stdout
    ARGV.pop until ARGV.empty?
  end

  it "does not play when there are no words found" do
    file = Tempfile.new 'play-with-examples_spec'
    file.write "will not match examples"
    file.close
    ARGV << file.path
    DocumentCache.new.clear

    load './bin/play-with-examples'

    @stdout.content.must_match(/Playing with 0 words/)
  end
end
