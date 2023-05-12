install.packages("tm")
install.packages("wordcloud")
install.packages("SnowballC")

library(tm)
library(wordcloud)
library(SnowballC)

myText = readLines('QStaxonomy.txt')
myCorpus <- Corpus(VectorSource(myText))

#Delete unnecessary white space
myCorpus <- tm_map(myCorpus, stripWhitespace)

#get the frequency
dataMatrix <- TermDocumentMatrix(myCorpus)
myMatrix <- as.matrix(dataMatrix)
mySortedMatrix <- sort(rowSums(myMatrix),decreasing=TRUE)
wordDataFrame <- data.frame(word = names(mySortedMatrix),freq=mySortedMatrix)
head(wordDataFrame)

#wordcloud(wordDataFrame$word,wordDataFrame$freq,min.freq=7)
wordcloud(wordDataFrame$word,wordDataFrame$freq,min.freq=7,
          colors=brewer.pal(7,"Paired"))

barplot(wordDataFrame[1:7,]$freq, las = 2, names.arg = wordDataFrame[1:7,]$word,
        col = "purple", main ="Question Sequence Taxonomy",
        ylab = "Frequency")
