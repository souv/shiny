rm(list=ls(all=TRUE))
# install.packages("jiebaR")
# install.packages("tm")
# install.packages("slam")
# install.packages("RColorBrewer")
# install.packages("wordcloud")
# install.packages("topicmodels")
# install.packages("igraph")
# install.packages("xml2")

library(jiebaRD)
library(jiebaR)       # �_���Q��
library(NLP)
library(tm)           # ��r���J�x�}�B��
library(slam)         # �}���x�}�B��
library(RColorBrewer)
library(wordcloud)    # ��r��
# library(topicmodels)  # �D�D�ҫ�
library(plyr)

source('chosePage.R')

#Sys.setlocale("LC_ALL", "cht")

result = chosePage(1,2)

orgPath = "./temp"
text = Corpus(DirSource(orgPath), list(language = NA))
text <- tm_map(text, removePunctuation)
text <- tm_map(text, removeNumbers)
text <- tm_map(text, function(word)
{ gsub("[A-Za-z0-9]", "", word) })

# �i�椤���_��
mixseg = worker()
mat <- matrix( unlist(text) )#��character�Φ�matrix
totalSegment = data.frame()

#�������j���x�}�ഫ����ƪ��A�������K���F�_��
for( j in 1:length(mat) )
{
  for( i in 1:length(mat[j,]) )
  {
    result = segment(as.character(mat[j,i]), jiebar=mixseg)
  }
  totalSegment = rbind(totalSegment, data.frame(result))
}

#�إ�term-document matrix
tdm <- TermDocumentMatrix(text, control = list(wordLengths = c(2, Inf)))
tdm
inspect(tdm[1:10, 1:2])

#�]��tm0.6��
# remove.packages("tm")
# install.packages("http://cran.r-project.org/bin/windows/contrib/3.0/tm_0.5-10.zip",repos=NULL)
# library(tm)


# define text array that you want
# delete text length < 2
delidx = which( nchar(as.vector(totalSegment[,1])) < 2 )#��which�Ӱ��D��s��
countText = totalSegment[-delidx,]#��h���פp��2������r���s��
countResult = count(countText)[,1]#�n����r������������r
countFreq = count(countText)[,2] / sum(count(countText)[,2]) #�ҥe�����
wordcloud(countResult, countFreq, min.freq = 1, random.order = F, ordered.colors = T, 
          colors = rainbow(length(countResult)))