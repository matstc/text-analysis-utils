require 'minitest/spec'
require 'minitest/autorun'
require_relative './spec_helper'

require_relative '../lib/game'

describe "Game" do
  it "picks answer choices" do
    game = Game.new ["rabbit", "horse", "hare", "lion", "mouse", "hamster"]
    choices = game.pick_choices_for "rabbit"
    choices.length.must_equal 5
    choices.must_include "rabbit"
  end

  it "knows proximity of two words" do
    game = Game.new []
    game.proximity("abc", "a").must_equal 2
    game.proximity("ab", "a").must_equal 1
    game.proximity("ä", "ae").must_equal 0
  end
end

