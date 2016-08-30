#http://rstudio-pubs-static.s3.amazonaws.com/12422_b2b48bb2da7942acaca5ace45bd8c60c.html
#tm包的問題http://stackoverflow.com/questions/24191728/documenttermmatrix-error-on-corpus-argument


orgPath = "./open_stock"
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

tdm <- TermDocumentMatrix(text, control = list(wordLengths = c(2,3)))
tdm
inspect(tdm[3:25, 1:144])
idx <- which(dimnames(tdm)$Terms == "配")
inspect(tdm[idx+(0:5),101:110])

#
findFreqTerms(tdm, lowfreq=2)
termFrequency <- rowSums(as.matrix(tdm))
termFrequency <- subset(termFrequency, termFrequency>=10)
library(ggplot2)
qplot(names(termFrequency), termFrequency, geom="bar", xlab="Terms") + coord_flip()
a=barplot(termFrequency, las=1)
findAssocs(tdm,"無",0.25)


library(plotly)
plotly(a)

#把每一行都用成一筆txt
setwd("C:\\Users\\user\\Desktop\\台大R\\台大_R\\shiny\\text_mining_example\\open_stock")
stock=read.csv("open_stock.csv")
# d <- split(stock,rep(1:144,each=1))

stock <- as.list(as.data.frame(t(stock)))
for (i in (1:length(stock))){
a=as.character(stock[[i]])
name=paste("number",i,".txt")
writeLines(a,name)
}

# define text array that you want
# delete text length < 2
delidx = which( nchar(as.vector(totalSegment[,1])) < 2 )#用which來做挑選編號
countText = totalSegment[-delidx,]#減去長度小於2的關鍵字的編號
countResult = count(countText)[,1]#要做文字雲的那些關鍵字
countFreq = count(countText)[,2] / sum(count(countText)[,2]) #所占的比例
wordcloud(countResult, countFreq, min.freq = 5, random.order = F, ordered.colors = T, 
          colors = rainbow(length(countResult)))