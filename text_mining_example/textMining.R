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
library(jiebaR)       # 斷詞利器
library(NLP)
library(tm)           # 文字詞彙矩陣運算
library(slam)         # 稀疏矩陣運算
library(RColorBrewer)
library(wordcloud)    # 文字雲
# library(topicmodels)  # 主題模型
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

# 進行中文斷詞
mixseg = worker()
mat <- matrix( unlist(text) )#把character用成matrix
totalSegment = data.frame()

#用雙重迴圈把矩陣轉換成資料表，當中順便做了斷詞
for( j in 1:length(mat) )
{
  for( i in 1:length(mat[j,]) )
  {
    result = segment(as.character(mat[j,i]), jiebar=mixseg)
  }
  totalSegment = rbind(totalSegment, data.frame(result))
}

#建立term-document matrix
tdm <- TermDocumentMatrix(text, control = list(wordLengths = c(2, Inf)))
tdm
inspect(tdm[1:10, 1:2])

#因為tm0.6版
# remove.packages("tm")
# install.packages("http://cran.r-project.org/bin/windows/contrib/3.0/tm_0.5-10.zip",repos=NULL)
# library(tm)


# define text array that you want
# delete text length < 2
delidx = which( nchar(as.vector(totalSegment[,1])) < 2 )#用which來做挑選編號
countText = totalSegment[-delidx,]#減去長度小於2的關鍵字的編號
countResult = count(countText)[,1]#要做文字雲的那些關鍵字
countFreq = count(countText)[,2] / sum(count(countText)[,2]) #所占的比例
wordcloud(countResult, countFreq, min.freq = 1, random.order = F, ordered.colors = T, 
          colors = rainbow(length(countResult)))