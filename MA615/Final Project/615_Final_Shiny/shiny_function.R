#year
#genre
#country
#company

# tmdb_detail
tmdb_detail = function(myyear,mycountry,mygenre){
  if(myyear == "whole" & mycountry != "whole" & mygenre != "whole"){
    main %>% 
      filter(str_detect(production_countries,mycountry)==TRUE) %>%
      filter(str_detect(genres,mygenre)==TRUE) %>%
      dplyr::select(title,original_title,runtime,vote_average,revenue)
  }
  else if(myyear != "whole" & mycountry == "whole" & mygenre != "whole"){
    main %>% 
      filter(release_year == myyear) %>%
      filter(str_detect(genres,mygenre)==TRUE) %>%
      dplyr::select(title,original_title,runtime,vote_average,revenue)
  }
  else if(myyear != "whole" & mycountry != "whole" & mygenre == "whole"){
    main %>% 
      filter(release_year == myyear) %>%
      filter(str_detect(production_countries,mycountry)==TRUE) %>%
      dplyr::select(title,original_title,runtime,vote_average,revenue)
  }
  else if(myyear != "whole" & mycountry == "whole" & mygenre == "whole"){
    main %>% 
      filter(release_year == myyear) %>%
      dplyr::select(title,original_title,runtime,vote_average,revenue)
  }
  else if(myyear == "whole" & mycountry != "whole" & mygenre == "whole"){
    main %>% 
      filter(str_detect(production_countries,mycountry)==TRUE) %>%
      dplyr::select(title,original_title,runtime,vote_average,revenue)
  }
  else if(myyear == "whole" & mycountry == "whole" & mygenre != "whole"){
    main %>% 
      filter(str_detect(genres,mygenre)==TRUE) %>%
      dplyr::select(title,original_title,runtime,vote_average,revenue)
  }
  else if(myyear != "whole" & mycountry != "whole" & mygenre != "whole"){
    main %>% 
      filter(release_year == myyear) %>%
      filter(str_detect(genres,mygenre)==TRUE) %>%
      filter(str_detect(production_countries,mycountry)==TRUE) %>%
      dplyr::select(title,original_title,runtime,vote_average,revenue)
  }
  else if(myyear == "whole" & mycountry == "whole" & mygenre == "whole"){
    main%>%
      dplyr::select(title,original_title,runtime,vote_average,revenue)
  }
}

tmdb_detail("whole","whole","whole")



#genre plot
#########
genre_year_plot=function(mygenre){
  gg= main %>% 
    filter(str_detect(genres,mygenre)==TRUE)
  ggplot(data=gg)+
    geom_line(aes(x=release_year),stat = "count")+
    xlab("Release Year") +
    ylab("Movie Count") +
    xlim(c(min(gg$release_year,na.rm = TRUE),max(gg$release_year,na.rm = TRUE)))+
    ggtitle(paste(mygenre,"Movie Count Of Each Year"))+
    theme(legend.position="none",
          plot.title=element_text(hjust=0.5),
          axis.title = element_text(size=10),
          axis.text.x = element_text(hjust=0.7))
}
genre_year_plot("Drama")

########
genre_country_plot=function(mygenre){
  gg= main %>% 
    filter(str_detect(genres,mygenre)==TRUE)
  
  #observe
  country_num <- str_count(gg$production_countries, "\\,")
  cou_max = max(na.exclude(unique(country_num)))+1
  #max=25
  
  #split into 8 cols
  country_df = str_split_fixed(gg$production_countries, ",", cou_max)
  country_name  = as.data.frame(country_df,stringsAsFactors = FALSE)
  
  #combine Vi into one col
  country_name[is.na(country_name)] <- ""
  
  country_count_df = as.data.frame(table(unlist(country_name)), stringsAsFactors = F)
  country_count_df = country_count_df[2:nrow(country_count_df),]
  country_count_df$Freq = as.numeric(country_count_df$Freq)
  
  country_count_df = country_count_df[order(country_count_df$Freq,decreasing = T),]
  country_count_df =head(country_count_df,20)

  ggplot(data=country_count_df,aes(x=reorder(Var1,Freq),y=Freq))+
    geom_bar(stat = "identity")+
    coord_flip()+
    xlab("Production Country") +
    ylab("Movie Count") +
    ggtitle(paste(mygenre,"Movie Count Of Each Country"))+
    geom_label(aes(label=as.character(Freq)),size=1)+
    theme(legend.position="none",
          plot.title=element_text(hjust=0.5),
          axis.title = element_text(size=10),
          axis.text.x = element_text(hjust=0.7))
}
genre_country_plot("Drama")






