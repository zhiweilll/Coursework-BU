#example

library(rjson)
library(RCurl)
library(httr)
library(dplyr)
library(rvest)
library(stringr)
### example
url='https://api.themoviedb.org/3/discover/movie?api_key=0283d56516e14a601c1cd05191293bec&sort_by=release_date.desc&primary_release_year=2000'
#&append_to_response=production_countries,production_companies,genres'
raw=httr::GET(url)
content <- httr::content(raw, as = 'text')
parsed=fromJSON(content)
p=parsed$results
df0=do.call(rbind,p)
d=as.data.frame(df)
parsed$total_pages

#### for loop example
df=d
for(i in 2:3){
  url=paste("https://api.themoviedb.org/3/discover/movie?api_key=0283d56516e14a601c1cd05191293bec&sort_by=vote_average.desc&vote_average.gte=1&page=",i,"&primary_release_year=2020")
  raw=httr::GET(url)
  content <- httr::content(raw, as = 'text')
  parsed=fromJSON(content)
  p=parsed$results
  df=rbind(df,as.data.frame(do.call(rbind,p)))
}
----------------------------------------------------------------------------------------------------------------



#### to get each year movies
tmdb_id=function(year){
url0=paste("https://api.themoviedb.org/3/discover/movie?api_key=0283d56516e14a601c1cd05191293bec&vote_average.gte=8&page=1","&primary_release_year=",year)
raw0=httr::GET(url0)
content0 <- httr::content(raw0, as = 'text')
parsed0=fromJSON(content0)
p0=parsed0$results
df0=as.data.frame(do.call(rbind,p0))
page=parsed0$total_pages

df=df0
for(i in 2:page){
url=paste("https://api.themoviedb.org/3/discover/movie?api_key=0283d56516e14a601c1cd05191293bec&vote_average.gte=8&page=",i,"&primary_release_year=",year)
raw=httr::GET(url)
content <- httr::content(raw, as = 'text')
parsed=fromJSON(content)
p=parsed$results
df=rbind(df,as.data.frame(do.call(rbind,p)))
}
return(df)
}

y2020=tmdb_id(2020)

--------------------------------------------------------------------------------------------------------
## Get the top rated/most popular movies on TMDb.
tmdb=function(filter){
  url0=paste("https://api.themoviedb.org/3/movie/",filter,"?api_key=0283d56516e14a601c1cd05191293bec&page=1")
  raw0=httr::GET(url0)
  content0 <- httr::content(raw0, as = 'text')
  parsed0=fromJSON(content0)
  p0=parsed0$results
  df0=as.data.frame(do.call(rbind,p0))
  page=parsed0$total_pages
  df=df0
for(i in 2:page){
  url=paste("https://api.themoviedb.org/3/movie/",filter,"?api_key=0283d56516e14a601c1cd05191293bec&page=",i)
  raw=httr::GET(url)
  content <- httr::content(raw, as = 'text')
  parsed=fromJSON(content)
  p=parsed$results
  df=rbind(df,as.data.frame(do.call(rbind,p)))
}
  return(df)
}

top_rate=tmdb("top_rated")

tt=as.data.frame(top_rate)
tt=tt[-2]
tt=tt[-2]
  col1=as.data.frame(unlist(tt[1]))
  col=col1
for(j in 2:12){
  col=cbind(col,as.data.frame(unlist(tt[j])))
}
colnames(col)=colnames(tt)  
#write.csv(col,"top_rate.csv")

#top_rate=read.csv("top_rate.csv")
id_list=data.frame(id=col$id)

---------------------------------------------------------------------------------------------------------------

##### get the details of those known id movies
get_tmdb=function(id){
myurl=paste("https://api.themoviedb.org/3/movie/",id,"?api_key=0283d56516e14a601c1cd05191293bec")
myraw=httr::GET(myurl)
mycontent <- httr::content(myraw, as = 'text')
myparsed=fromJSON(mycontent)

id=myparsed$id
collection=p$belongs_to_collection
budget=myparsed$budget
revenue=myparsed$revenue
runtime=myparsed$runtime
status=myparsed$status
genre=myparsed$genres
country=myparsed$production_countries
company=myparsed$production_companies
spoken=myparsed$spoken_languages

com=str_c(as.data.frame(do.call(cbind,company))[3:4,],collapse = ",")
coun=str_c(as.data.frame(do.call(cbind,country))[2,],collapse = ",")
gen=str_c(as.data.frame(do.call(cbind,genre))[2,],collapse = ",")
spok=str_c(as.data.frame(do.call(cbind,spoken))[1,],collapse = ",")

coll= if(is.null(collection)==TRUE){
 NA}
else{
 collection}
  
df=data.frame(id=character(),
              collection=character(),
              budget=character(),
              revenue=character(),
              runtime=character(),
              status=character(),
              genre=character(),
              country=character(),
              company=character(),
              spoken_language=character())
df[1,1]=id
df[1,2]=coll
df[1,3]=budget
df[1,4]=revenue
df[1,5]=runtime
df[1,6]=status
df[1,7]=gen
df[1,8]=coun
df[1,9]=com
df[1,10]=spok
return(df)
}

get_tmdb(id_list[6236,])

tmdb_data = NULL
for (i in 1:nrow(id_list)) {
  tmdb_data  = rbind(tmdb_data,get_tmdb(id_list[i,]))
}



------------------------------------------------------------------------------------------------------------------------
##### Improve the get_tmdb() 
# There are many NULL and empty list() in the data, which will stop the function
# So we need to change the empty value into NA
  get_tmdb_2=function(id){
    myurl=paste("https://api.themoviedb.org/3/movie/",id,"?api_key=0283d56516e14a601c1cd05191293bec")
    myraw=httr::GET(myurl)
    mycontent <- httr::content(myraw, as = 'text')
    myparsed=fromJSON(mycontent)
    
    id=myparsed$id
    
    collection=ifelse(is.null(myparsed$belongs_to_collection)==TRUE,NA,myparsed$belongs_to_collection)
  
    budget= ifelse(is.null(myparsed$budget)==TRUE,NA,myparsed$budget)

    revenue=ifelse(is.null(myparsed$revenue)==TRUE,NA,myparsed$revenue)
      
    runtime=ifelse(is.null(myparsed$runtime)==TRUE,NA,myparsed$runtime)
      
    status=ifelse(is.null(myparsed$status)==TRUE,NA,myparsed$status)

    genre=ifelse(length(myparsed$genres)==0,NA,str_c(as.data.frame(do.call(cbind,myparsed$genres))[2,],collapse = ","))
    
    country=ifelse(length(myparsed$production_countries)==0,
                   NA,
                   str_c(as.data.frame(do.call(cbind,myparsed$production_countries))[2,],collapse = ","))

    company=ifelse(length(myparsed$production_companies)==0,
                   NA,
                   str_c(as.data.frame(do.call(cbind,myparsed$production_companies))[3:4,],collapse = ","))
    
    spoken=ifelse(length(myparsed$spoken_languages)==0,
                  NA,
                  str_c(as.data.frame(do.call(cbind,myparsed$spoken_languages))[1,],collapse = ","))
    
    df=data.frame(id=character(),
                  collection=character(),
                  budget=character(),
                  revenue=character(),
                  runtime=character(),
                  status=character(),
                  genre=character(),
                  country=character(),
                  company=character(),
                  spoken_language=character())
    df[1,1]=id
    df[1,2]=collection
    df[1,3]=budget
    df[1,4]=revenue
    df[1,5]=runtime
    df[1,6]=status
    df[1,7]=genre
    df[1,8]=country
    df[1,9]=company
    df[1,10]=spoken
    return(df)
  }

#get_tmdb_2(id_list[6747,])
             
  tmdb_data_5 = NULL
  for (i in 1:nrow(id_list)) {
    tmdb_data_5  = rbind(tmdb_data_5,get_tmdb_2(id_list[i,]))
  }
  
  #use the 1st function, STOP IN 6747, then use the 2nd function to continue
  
  tmdb_data_7 = NULL
  for (i in 6747:nrow(id_list)) {
    tmdb_data_7  = rbind(tmdb_data_7,get_tmdb_2(id_list[i,]))
  }
  
tmdb_data=rbind(tmdb_data_5,tmdb_data_7)

write.csv(tmdb_data,"tmdb_data.csv")


# rewrite for company and collection
get_company=function(id){
    myurl=paste("https://api.themoviedb.org/3/movie/",id,"?api_key=0283d56516e14a601c1cd05191293bec")
    myraw=httr::GET(myurl)
    mycontent <- httr::content(myraw, as = 'text')
    myparsed=fromJSON(mycontent)
    
    id=myparsed$id
    collection=ifelse(length(myparsed$belongs_to_collection)==0,
                      NA,
                      str_c(as.data.frame(myparsed$belongs_to_collection$name),collapse = ","))
    company=ifelse(length(myparsed$production_companies)==0,
                   NA,
                   str_c(as.data.frame(do.call(cbind,myparsed$production_companies))[3,],collapse = ","))
    
    df=data.frame(id=character(),
                  company=character(),
                  collection=character())
    df[1,1]=id
    df[1,2]=company
    df[1,3]=collection
    return(df)
  }

top_rate = read.csv("top_rate.csv")
id_list = as.data.frame(top_rate$id)
tmdb_company = NULL
for (i in 1:nrow(id_list)) {
  tmdb_company = rbind(tmdb_company,get_company(id_list[i,]))
}

write.csv(tmdb_company,"1.csv")

tmdb_company_2=NULL

for (i in 5718:nrow(id_list)) {
  tmdb_company_2 = rbind(tmdb_company,get_company(id_list[i,]))
}