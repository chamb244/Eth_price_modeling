# formatting maize price data for 2007 EC (2014-2015)

setwd("C:/DATA/Ethiopia/price_modeling/Kevin/EthPriceModelling/output/ETHPriceData/")
list.files()
df <- read.csv("5.Retail price 2007 E.C.csv")
summary(df) 
names(df) 
head(df)
df <- df[-c(1,3),-c(1)]
summary(df)
sapply(df, class) 
head(df)

names(df)

colnames(df)[colnames(df) == "Unmilled.Maize.Price.Birr.KG"  ] <- "pkg.mai.maize"
colnames(df)[colnames(df) == "Milled.Maize.Price.Birr.KG"  ] <- "pkg.mai.millm" 

names(df) 
head(df)
# fix data type
sapply(df, class)

# transform(df, Year = as.numeric(Year))
# 
# sapply(df[,-c(1:3)], function(x) {
#   transform(df, x = as.numeric(x))
#   })

convert_char_to_numeric <- function(w) {
  # Use sapply to apply a function to each column of the dataframe
  w[] <- lapply(w, function(x) {
    # Check if the column is of type character
    if(is.character(x)) {
      # Convert character to numeric
      as.numeric(as.character(x))
    } else {
      # If not character, leave the column as is
      x
    }
  })
  return(w)
}

df[,c(4:length(df))] <- convert_char_to_numeric(df[,c(4:length(df))])
summary(df)

# convert text values to standardized values
df[,"Region"] <- stringr::str_to_title(df$Region)
df[,"Market"] <- stringr::str_to_title(df$Market)
df[,"Month"] <- stringr::str_to_sentence(df$Month)

# check spatial & temporal coverage 
unique(df$Region) # need to be encoded
unique(df$Market) # need to be standardized/coded & assigned coordinates
unique(df$Year) # only 2016 & 2017
unique(df$Month) # 


# fix missing year values
table(df$Year, df$Month, useNA="ifany")
dim(df[is.na(df$Year),])
# these are all for October and seem to be duplicates
# drop for now... 

df <- df[!(df$Month=="October.doc"),]
# # alternatively, uncomment these lines and adapt to correct values 
# df$Month[df$Month=="October.doc"] <- "October"
# df$Year[df$Month=="September"] <- 2013




write.csv(df, file = "reformatted_pkg_mai_2007_ec.csv")
