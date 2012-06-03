# Questions these utils are meant to answer

### How many vocabulary words do I know?

  \>$ ruby vocabulary-chest.rb

### What are the words I read most frequently?

  \>$ ruby document-cache.rb

### How easy to read is this hypothetical article?

  \>$ readability-of [text or file]

### What percentage of words do I know from this piece of text?

  \>$ percentage-known-of [text or file]

### How is this word used in an example sentence?

  \>$ find-examples-of --3 [word]


# Tools for text analysis
### proximity-of-words
Call this utility with a first file to analyse, and an arbitrary number of other files containing known words.

For each word in the first file, this script will output the closest word found in all the other files, and the Levensthein distance between the two.

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
