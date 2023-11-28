# pool together price files

setwd("C:/DATA/Ethiopia/price_modeling/Kevin/EthPriceModelling/output/ETHPriceData/")
list.files()

flist <- c("reformatted_pkg_wht_2006_ec.csv", "reformatted_pkg_wht_2007_ec.csv",    
           "reformatted_pkg_wht_2008_ec.csv", "reformatted_pkg_wht_2009_ec.csv",    
           "reformatted_pkg_wht_2010_ec.csv", "reformatted_pkg_wht_2011_ec.csv")

for (i in 1:length(flist)) {
  print(paste("file", i, ":", flist[i]))
  if (i==1) {
    mydf <- data.table(read.csv(flist[i]))
  } else {
    tmp <- data.table(read.csv(flist[i]))
    mydf <- rbind(mydf,tmp, fill=TRUE)
  }
  i <- i+1
}

mydf 
# count non-missing values for each column 
mydf[, lapply(.SD, function(x) sum(!is.na(x)))]

# # this code will do same as loop above:
# junk1 <- data.table(read.csv("reformatted_pkg_wht_2011_ec.csv"))
# junk2 <- data.table(read.csv("reformatted_pkg_wht_2010_ec.csv"))
# junk3 <- data.table(read.csv("reformatted_pkg_wht_2009_ec.csv"))
# junk4 <- data.table(read.csv("reformatted_pkg_wht_2008_ec.csv"))
# junk5 <- data.table(read.csv("reformatted_pkg_wht_2007_ec.csv"))
# junk6 <- data.table(read.csv("reformatted_pkg_wht_2006_ec.csv"))
# junkall <- rbind(junk1, junk2, junk3, junk4, junk5, junk6, fill=TRUE)
# dim(junkall)

fwrite(mydf, file="reformatted_pkg_wht_allyears.csv")
