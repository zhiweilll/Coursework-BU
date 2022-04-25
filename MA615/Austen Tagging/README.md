# [This is our group report link](https://ron-li.github.io/MA615text_mining/Tagging-Project.html)

# MA615 Tagging Text
## ---- Jane Austen Novels 

#### Assignment Description
Use the tools and notes from Allen Razdow's Truenumbers talk.  Explore Jane Austen's work using tnum fuctions to search and tag aspects of the work that reflect your thoughts and speculations.  You might for example tag the sentences in which Darcy and Elizabeth co-occur.  Counting these tags could give you a bar chart that shows how the counts of these sentences are distributed by chapter.  As Allen suggested, you might find the sentences where money is mentioned.  How significant are the amounts?  Translating the amounts into terms that make them understandable (related to mean annual income at the time, for example). 

Remember, that you will see tagging in the dats from all of the groups -- because the database is shared.  If Pride and Prejudice get's loaded with tags and you want to try tnum in a less cluttered space, go to another of the Austen books.  They will all have synopses that are readily available online.

To install the tnum library run this line: `devtools::install_github("truenumbers/tnum/tnum")`From there, use Allen's code as a guide.

The deliverable for this project are plots and explanations of what they mean.  


#### Reference

- [tnum package](https://github.com/Truenumbers/tnum)  
we use this package for text analysis

- [get start with tnum](https://github.com/Truenumbers/tnum/tree/master/tnum/inst/Rmd)

- [jane austen package](https://github.com/juliasilge/janeaustenr)  
This package provides access to the full texts of Jane Austen's 6 completed, published novels. 

- [Text Mining with R](https://www.tidytextmining.com/)
