require 'minitest/spec'
require 'minitest/autorun'
require_relative './spec_helper'

require_relative '../lib/algorithms'

describe "Counting syllables" do
  it "counts three-letter words as one syllable" do
    Algorithms::syllable_count("aid").must_equal 1
    Algorithms::syllable_count("pot").must_equal 1
    Algorithms::syllable_count("pat").must_equal 1
  end

  it "does not count as a syllable the final quiet syllable" do
    Algorithms::syllable_count("finished").must_equal 2
    Algorithms::syllable_count("species").must_equal 2
    Algorithms::syllable_count("polished").must_equal 2
  end

  it "counts a normal word with two vowels as two syllables" do
    Algorithms::syllable_count("cockney").must_equal 2
    Algorithms::syllable_count("parrot").must_equal 2
    Algorithms::syllable_count("nuggat").must_equal 2
  end

  it "computes the sachtextformel according to specs" do
    Algorithms::wiener_sachtextformel(4, 12, 1.0/12*100).must_equal 1.39
  end

  it "computes the grade level according to specs" do
    Algorithms::grade(4, 12, 24).must_equal 9.18
  end
end

