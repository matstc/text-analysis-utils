require 'minitest/spec'
require 'minitest/autorun'
require_relative './spec_helper'

require_relative '../lib/vocabulary-chest'

describe "TAU Config" do
  before do
    @old_value = ENV['vocabulary_chest_language']
  end

  after do
    ENV['vocabulary_chest_language'] = @old_value
  end

  it "knows the specified language" do
    ENV['vocabulary_chest_language'] = 'fr'
    TAUConfig.language.must_equal "fr"
  end
end
