require 'minitest/spec'
require 'minitest/autorun'
require_relative '../spec_helper'
require 'tempfile.rb'

describe "frequency-list" do

  before do
    @stdout = mock_stdout
    @old_stdout = $stdout
    $stdout = @stdout

    @cache = DocumentCache.new
    @cache.clear
  end

  after do
    $stdout = @old_stdout
  end

  it "lists out frequent words" do
    @cache.add "this this is a"
    load './bin/frequency-list'
    @stdout.content.must_equal "2\tthis\tthis,this\n1\tis\tis\n1\ta\ta\n"
  end
end
