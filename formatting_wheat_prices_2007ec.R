# formatting wheat price data for 2007 EC (2014-2015)

setwd("C:/DATA/Ethiopia/price_modeling/Kevin/EthPriceModelling/output/ETHPriceData/")
list.files()
df <- read.csv("5.Retail price 2007 E.C_wheat.csv")
summary(df) 
names(df) 
head(df)
df <- df[-c(1,3),-c(1)]
summary(df)
sapply(df, class) 
head(df)

names(df)

colnames(df)[colnames(df) == "CEREALS.UNMILLED_Wheat.White"] <- "pkg.wht.white"
colnames(df)[colnames(df) == "CEREALS.UNMILLED_Wheat.Mixed"] <- "pkg.wht.mixed"
colnames(df)[colnames(df) == "CEREALS.UNMILLED_Wheat.Black..Red."] <- "pkg.wht.blred"
colnames(df)[colnames(df) == "CEREALS.MILLED_Wheat.White"] <- "pkg.wht.millw"
colnames(df)[colnames(df) == "CEREALS.MILLED_Wheat.Mixed"] <- "pkg.wht.millm"            
colnames(df)[colnames(df) == "BREAD.AND.OTHER.PREPARED.FOODS_Bread.Wheat..Bakery."] <- "pkg.wht.bread"
colnames(df)[colnames(df) == "P.R.I.C.E...I.N....B.I.R.R_Malt.Wheat"] <- "pkg.wht.maltw"



names(df) 
head(df)
# fix data type
sapply(df, class)

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
unique(df$Year) # only 2017 & 2018
  table(df$Year, df$Month, useNA="ifany")
  dim(df[is.na(df$Year),])
  # these are all for October, so set year to 
unique(df$Month) # 


# check means and pair-wise correlation between different wheat grain prices
summary(df[,c("pkg.wht.white", "pkg.wht.mixed", "pkg.wht.blred")])
cor(df[,c("pkg.wht.white", "pkg.wht.mixed", "pkg.wht.blred")], use = "complete.obs")


# create composite 
df[,"pkg.wht.allwh"] <- df$pkg.wht.white
df$pkg.wht.allwh <- ifelse(is.na(df$pkg.wht.allwh), df$pkg.wht.blred, df$pkg.wht.allwh)
df$pkg.wht.allwh <- ifelse(is.na(df$pkg.wht.allwh), df$pkg.wht.mixed, df$pkg.wht.allwh)
summary(df$pkg.wht.allwh)

write.csv(df, file = "reformatted_pkg_wht_2007_ec.csv")

