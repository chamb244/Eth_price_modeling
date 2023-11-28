# formatting barely price data for 2006 EC (2013-2014)

setwd("C:/DATA/Ethiopia/price_modeling/Kevin/EthPriceModelling/output/ETHPriceData/")
list.files()
df <- read.csv("4.Retail price 2006 E.C_barley.csv")
summary(df) 
names(df) 
head(df)
df <- df[-c(1,3),-c(1)]
summary(df)
sapply(df, class) 
head(df)

names(df)

colnames(df)[colnames(df) == "CEREALS.UNMILLED_Barley.White"] <- "pkg.bar.white"
colnames(df)[colnames(df) == "CEREALS.UNMILLED_Barley.Mixed"] <- "pkg.bar.mixed"
colnames(df)[colnames(df) == "CEREALS.UNMILLED_Barley.Black"] <- "pkg.bar.black"

colnames(df)[colnames(df) == "CEREALS.UNMILLED_Barley.for.Beer"] <- "pkg.bar.bbeer"
colnames(df)[colnames(df) == "CEREALS.UNMILLED_Hulled.Barley"] <- "pkg.bar.hullb"

colnames(df)[colnames(df) == "CEREALS.MILLED_Barley.White"] <- "pkg.bar.millw"
colnames(df)[colnames(df) == "CEREALS.MILLED_Barley.Mixed"] <- "pkg.bar.millm"

colnames(df)[colnames(df) == "P.R.I.C.E...I.N....B.I.R.R_Malt.Barley"] <- "pkg.bar.maltb"



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
# these are all for September, which seems the reason for non-assignment of year

df$Month[df$Month=="September(1)"] <- "September"
df$Year[df$Month=="September"] <- 2013



# check means and pair-wise correlation between different wheat grain prices
summary(df[,c("pkg.bar.white", "pkg.bar.black", "pkg.bar.mixed")])
cor(df[,c("pkg.bar.white", "pkg.bar.black", "pkg.bar.mixed")], use = "complete.obs")


# create composite 
df[,"pkg.bar.allba"] <- df$pkg.bar.white
df$pkg.bar.allba <- ifelse(is.na(df$pkg.bar.allba), df$pkg.bar.black, df$pkg.bar.allba)
df$pkg.bar.allba <- ifelse(is.na(df$pkg.bar.allba), df$pkg.bar.mixed, df$pkg.bar.allba)
summary(df$pkg.bar.allba)

write.csv(df, file = "reformatted_pkg_bar_2006_ec.csv")
