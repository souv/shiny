#抓到標題://span[@class="subject-text"]/a/text()
#抓到回復數://td/text()
#作者與日期://td/a/p/text()

#網站的頁面設定(就是p在做改變而已):http://www.mobile01.com/topiclist.php?f=291&p=5


rm(list=ls(all=TRUE))
library(XML)
library(bitops)
library(RCurl)
library(httr)
library(xml2)

orgURL = 'http://www.mobile01.com/topiclist.php?f=291&p=1'

url <-"http://www.mobile01.com/topiclist.php?f=291&p=1"
#download.file(url,"C:\\Users\\user\\Desktop\\cnyes.html")
doc <- read_html(url) 

startPage = 1
endPage = 10
alldata = data.frame()

#抓一個網址的就好了
url.exists(orgURL)

for( i in startPage:endPage)#這個迴圈跑一次就代表跑一個頁面的資料
{ 
  pttURL <- paste(orgURL,i, sep='')
  urlExists = url.exists(pttURL)
  
  if(urlExists)
  {
    html = getURL(pttURL, ssl.verifypeer = FALSE)
    xml = htmlParse(html, encoding ='utf-8')
    title = xpathSApply(xml, "//span[@class='subject-text']/a/text()", xmlValue)
    author =xpathSApply(xml,"//td/a/p/text()",xmlValue)
    response = xpathSApply(xml, "//td/text()", xmlValue)
    tempdata = data.frame(title, author, response)
  }
  alldata = rbind(alldata, tempdata)
}

allDate = levels(alldata$date)
res = hist(as.numeric(alldata$date), nclass=length(allDate), axes=F) 
axis(1, at=1:length(allDate), labels=allDate)
axis(2, at=1:max(res$counts), labels=1:max(res$counts))