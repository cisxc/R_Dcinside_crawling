
install.packages("RSelenium")
install.packages("XML")
install.packages('wordcloud2') 
install.packages("KoNLP")
##################################################
library(RSelenium) 
library(XML)
library(wordcloud2)
library("KoNLP")  
install.packages("KoNLP")


useSejongDic()
remDr <- remoteDriver(remoteServerAddr = 'localhost', 
                      port = 4445L, # 포트번호 입력 
                      browserName = "chrome") 

remDr$open() 

all.title <- c()

url = 'https://gall.dcinside.com/board/lists/?id=chonbuk&list_num=100&sort_type=N&search_head=&page='


for(page in 1:5){
  
  url = 'https://gall.dcinside.com/board/lists/?id=seouluniversity&list_num=100&sort_type=N&search_head=&page='
  url <- paste(url,page,sep='')
  # read_html 함수를 사용하여 html 페이지를 htxt 변수에 저장
  remDr$navigate(url)
  
  page_source = remDr$getPageSource()[[1]]
  
  title <-read_html(page_source) %>%
    html_nodes(xpath='//*[@id="container"]/section[1]/article[2]/div[2]/table/tbody/tr[*]/td[2]/a[1]/text()')%>%
    html_text()
  

  
  all.title <- c(all.title, title)
 
}


####문자 분리하기 

reviews.word <- sapply(all.title, extractNoun, USE.NAMES = F)
reviews.word
word_vector = unlist(reviews.word)
word_vector
###############

word_vector <- Filter(function(x){nchar(x)>=2 && nchar(x)<=5}, word_vector)

name = table(word_vector)

windows()
palete = brewer.pal(9,"Set1")
wordcount <- head(sort(name,decreasing=T),200)

wordcloud2(wordcount,fontFamily = '나눔바른고딕')


