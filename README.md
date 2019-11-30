# Dcinside 대학 분위기 분석
www.dcinside.com 사이트를 R를 이용하여 분석을 해본다.
****
<h2> 1. 사용 라이브러리 </h2>

* library("R6")
* library("XML")
* library("wordcloud2")
* library(RSelenium) 
* library("KoNLP")  

<h2> 2. 프로그램 소개 </h2>

* https://gall.dcinside.com 파싱
* 각 5000개의 데이터를 분석하였다
* DC 갤러리의 제목들을 크롤링
* 워드클라우드2를 활용하여 대학교 성향 및 분위기 분석

<h2> 3. 데이터의 모은이유 </h2>

* 게시글의 성향에 제한이 없다.
* 대학별 트렌트나 주요 이슈에 영향을 많이 받는다.
* 글의 리젠 속도가 빠르다.

 ****
 
 <h2> 4. 코드 설명 </h2>
 
 <h3> 4.1. 셀레니움 연결 </h3>
 
~~~
 
useSejongDic() #단어 사전 업로드

### 셀레니움 연결
remDr <- remoteDriver(remoteServerAddr = 'localhost', 
                      port = 4445L, # 포트번호 입력 
                      browserName = "chrome") 
remDr$open() 

 
 ~~~
 
<h3> 4.2. 메인코드 </h3>
 
~~~
 
### 제목 벡터 생성

all.title <- c()


####100개씩 5페이지를 가져옴 
for(page in 1:5){
  
  url = 'https://gall.dcinside.com/board/lists/?id=koreauniversity&list_num=100&sort_type=N&search_head=&page='
  url <- paste(url,page,sep='')
  # read_html 함수를 사용하여 html 페이지를 htxt 변수에 저장
  remDr$navigate(url)
  
  page_source = remDr$getPageSource()[[1]]
  
  title <-read_html(page_source) %>%
    html_nodes(xpath='//*[@id="container"]/section[1]/article[2]/div[2]/table/tbody/tr[*]/td[2]/a[1]/text()')%>%
    html_text()
  

  
  all.title <- c(all.title, title)
 
}

~~~

<h3> 4.3. 워드클라우드2 </h3>
 
~~~

###문자 분리하기 

reviews.word <- sapply(all.title, extractNoun, USE.NAMES = F)
word_vector = unlist(reviews.word)
word_vector <- Filter(function(x){nchar(x)>=2 && nchar(x)<=5}, word_vector)
name = table(word_vector)

###워드클라우드2
wordcount <- head(sort(name,decreasing=T),200)
wordcloud2(wordcount,fontFamily = '나눔바른고딕')


~~~
 
 ****
 
<h2> 5. 실행 및 분석 결과 </h2>

<h3> 5.1. 전북대 </h3>

![Alt text](/img/JBNU.JPG)

<h3> 5.2. 서울대 </h3>

![Alt text](/img/SU.JPG)

<h3> 5.3. 연세대 </h3>

![Alt text](/img/YU.JPG)

<h3> 5.4. 고려대 </h3>

![Alt text](/img/KU.JPG)

<h3> 5.5. 전남대 </h3>

![Alt text](/img/JNNU.JPG)

****

<h2> 6. 분석결과 </h2>

* 상위권 대학에 있을 수록 정치에 관련한 글이 많이 분포한다.
* 중위권 대학은 입학과 서열에 민감하게 반응한다.
* 대학의 수준별로 비슷한 분위기를 품고있다.

****
