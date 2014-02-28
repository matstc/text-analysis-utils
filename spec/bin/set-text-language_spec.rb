require 'minitest/spec'
require 'minitest/autorun'
require_relative '../spec_helper'
require 'tempfile.rb'
require_relative '../../lib/tau_config'

describe "set-text-language" do
  after do
    ARGV.pop until ARGV.empty?
  end

  it "changes the default language" do
    TAUConfig.language.must_equal "en"
    ARGV << 'de'
    load './bin/set-text-language'
    TAUConfig.language.must_equal "de"
  end
end
