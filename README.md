# Dcinside 대학 분위기 분석
www.dcinside.com 사이트를 R를 이용하여 분석을 해본다.
****
<h2> 사용 라이브러리 </h2>

* library("R6")
* library("XML")
* library("wordcloud2")
* library(RSelenium) 
* library("KoNLP")  

<h2> 프로그램 소개 </h2>

* https://movie.naver.com/movie/point/af/list.nhn 파싱
* 각 5000개의 데이터를 분석하였다
* DC 갤러리의 제목들을 크롤링
* 워드클라우드2를 활용하여 대학교 성향 및 분위기 분석

 ****
 
 <h2> 코드 설명 </h2>
 
 
 
 ****
 
<h2> 실행 및 분석 결과 </h2>

<h3> 분석 웹 페이지 </h3>

![Alt text](/img/SU.JPG)

<h3> 겨울 왕국을 제외한 최근 영화 빈도수와 평점 </h3>

* 겨울왕국은 빈도수가 앞도적으로 높아 같이 분석을 할 수 없었다.

![Alt text](/img/movie_gragh.JPG)

<h3> 영화 단어 클라우드 </h3>

![Alt text](/img/Movie_freg.JPG)

<h3> 전체 영화 댓글 단어클라우드(단어수 3개 이상)  </h3>

![Alt text](/img/Movie_issue.JPG)

