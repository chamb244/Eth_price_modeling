# formatting barley price data for 2006 EC (2013-2014)
# formatting barley price data for 2007 EC (2014-2015)
# formatting barley price data for 2008 EC (2015-2016)
# formatting barley price data for 2009 EC (2016-2017)
# formatting barley price data for 2010 EC (2017-2018)
# formatting barley price data for 2011 EC (2018-2019)
# formatting barley price data for 2012 EC (2019-2020)

setwd("C:/DATA/Ethiopia/price_modeling/Kevin/EthPriceModelling/output/ETHPriceData/")
list.files(pattern=".csv$")
df <- read.csv("8. Retail price 2011 E.C_barley.csv")
head(df) 
# drop first and third lines; drop first column
df <- df[-c(1,3),-c(1)]
summary(df)
sapply(df, class) 

names(df)

colnames(df)[colnames(df) == "X01.1.1.2.UNMILLED.CEREALS.GRAINS_Barley.White"  ] <- "pkg.bar.white"
colnames(df)[colnames(df) == "X01.1.1.2.UNMILLED.CEREALS.GRAINS_Barley.Mixed"   ] <- "pkg.bar.mixed"       
colnames(df)[colnames(df) == "X01.1.1.2.UNMILLED.CEREALS.GRAINS_Barley.Black"         ] <- "pkg.bar.black"   
colnames(df)[colnames(df) == "X01.1.1.2.UNMILLED.CEREALS.GRAINS_Barley.for.Beer"      ] <- "pkg.bar.bbeer"   
colnames(df)[colnames(df) == "P.R.I.C.E...I.N....B.I.R.R_Hulled.Barley..Temez."       ] <- "pkg.bar.temez"   
colnames(df)[colnames(df) == "CEREALS.MILLED_Barley.White"                            ] <- "pkg.bar.millw"   
colnames(df)[colnames(df) == "CEREALS.MILLED_Barley.Mixed"                            ] <- "pkg.bar.millm"   
colnames(df)[colnames(df) == "X01.2.1.1.COFFEE.AND.TEA_Malt.Barley"                   ] <- "pkg.bar.maltb"   
colnames(df)[colnames(df) == "X01.1.1.2.UNMILLED.CEREALS.GRAINS_Hulled.Barley..Temez."] <- "pkg.bar.hullb"   


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
unique(df$Year) # only 2018 & 2019
unique(df$Month) # missing June

table(df$Year, df$Month, useNA="ifany")


psych::corr.test(df[,-c(1:6)])

# create composite 
df[,"pkg.bar.allba"] <- df$pkg.bar.white
df$pkg.bar.allba <- ifelse(is.na(df$pkg.bar.allba), df$pkg.bar.mixed, df$pkg.bar.allba)
df$pkg.bar.allba <- ifelse(is.na(df$pkg.bar.allba), df$pkg.bar.black, df$pkg.bar.allba)
summary(df$pkg.bar.allba)

write.csv(df, file = "reformatted_pkg_bar_2011_ec.csv")
