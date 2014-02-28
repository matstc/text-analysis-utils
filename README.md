[![Build Status](https://travis-ci.org/matstc/text-analysis-utils.png?branch=master)](https://travis-ci.org/matstc/text-analysis-utils) [![Gem Version](https://badge.fury.io/rb/text-analysis-utils.png)](http://badge.fury.io/rb/text-analysis-utils)

# Install
    gem install text-analysis-utils

# How To Use
When learning a language...

If you're not learning English, set the language you are learning:

    set-text-language <fr|de|es|...>

Whenever you read a piece of text, cache it in your document cache:

    cache-document <file>

You can also call `cache-document` without an argument and paste the text (use `control-D` when you're done).

Once you have cached a few articles, you can retrieve example sentences easily:

    find-examples-for <word>

You can also list the words in your cache by frequency of occurrences:

    frequency-list

You can also tell the gem what words you know:

    classify-new-words <file>

Or call it without an argument to paste a piece of text. The gem will ask you whether you known each word in turn. This process is tedious but useful. If you go through this process assiduously, you'll be able to know the size of your vocabulary:

    vocabulary-size

And if you are unsure what words to learn next, use this command to list the most frequent words you do not know:

    frequency-list --unknown

Want to practice vocabulary? Play fill-in-the-blanks:

    play-with-examples <file>

The file you pass in should contain a list of words, one per line.

## Questions That Now Have Answers

### How many vocabulary words do I know?

    $ vocabulary-size

    #= You know 432 words.

### What are the words I read most frequently?

    $ frequency-list

    #=
    3	hello	hello,hello
    2	dear	dear
    1	my	my
    1	a	a

### How easy to read is this hypothetical article?

    $ readability-of [text or file]

    #=
    Number of sentences: 2.0
    Number of words: 26.0
    Number of syllabes: 33.3
    Average number of syllables per word: 1.28
    Average number of words per sentence: 13.00
    Wiener Sachtextformel: 2.82
    Flesch-Kincaid Grade Level: 4.59

### What percentage of words do I know from this piece of text?

    $ percentage-known-of [text or file]

    #=
    UNKNOWN WORDS: what, percentage, do, of

    Total number of unknown words: 4
    Total number of known words: 6
    Total number of words: 10
    Percentage of words known: 60.00%

### How is this word used in an example sentence?

    $ find-examples-of -2 uncle

    #=
    This is my uncle Bob.
    What a good uncle.

## Overview of All The Utilities

### readability-of
Call this script on a piece of text to print out statistics like average sentence length or the Flesch-Kincaid grade level.

### classify-new-words
Call this script with some text or files to tell your vocabulary chest which words you already know.

### percentage-known-of
This script will tell you how many words you already know from the given text or file.

### cache-document
This script will store whatever text is given to it in the document cache.

### find-examples-for
This script will output example sentences taken from the document cache.

### play-with-examples
This scripts accepts a list of words to practice and will prompt the user to complete sentences taken from the document cache.

### vocabulary-size
Counts the number of known words.

### frequency-list
Lists words by frequencies. Can be made to list known or unknown words.

# License
[CC BY-NC-SA 4.0](http://creativecommons.org/licenses/by-nc-sa/4.0/)
