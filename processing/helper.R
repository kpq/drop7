# for i in *; do tesseract "$i" "../output/${i}-modified"; done

setwd("/Users/200708/personal/drop7/working/output")


fetchNumber <- function(str, file) {
  if  (nrow(file) > 14 || (ncol(file) == 0 )) {
    return (NA)
  } else {
    stringy <- as.character(file[,1][grep(str, file[,1])[1]])
    num <- as.numeric(gsub("\\,", "", sapply(strsplit(stringy, str), function(x) { x[[2]]})))
    return (num)
  }
}

getDataForFile <- function(url) {
  file <- read.delim(url)
  score <- fetchNumber("Score", file)
  chain <- fetchNumber("Longest Chain", file)
  level <- fetchNumber("Level Reached", file)
  prev <- fetchNumber("Prev. Average Score", file)
  new <- fetchNumber("New Average Score", file)
  df <- data.frame(score=score, chain=chain, level=level, prev=prev, new=new, url=url)

  return (df)
}


paths <- dir()
data <- NULL

for (i in paths) {
  d <- getDataForFile(i)
  data <- rbind(d, data)
}

