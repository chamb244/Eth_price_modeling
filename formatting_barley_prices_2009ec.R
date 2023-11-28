# formatting barley price data for 2006 EC (2013-2014)
# formatting barley price data for 2007 EC (2014-2015)
# formatting barley price data for 2008 EC (2015-2016)
# formatting barley price data for 2009 EC (2016-2017)

setwd("C:/DATA/Ethiopia/price_modeling/Kevin/EthPriceModelling/output/ETHPriceData/")
list.files(pattern=".csv$")
df <- read.csv("7. Retail price 2009 E.C_barley.csv")
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

colnames(df)[colnames(df) == "CEREALS.UNMILLED_Barley.White"            ] <- "pkg.bar.white2"
colnames(df)[colnames(df) == "CEREALS.UNMILLED_Barley.Mixed"            ] <- "pkg.bar.mixed2"
colnames(df)[colnames(df) == "CEREALS.UNMILLED_Barley.Black"            ] <- "pkg.bar.black2"
colnames(df)[colnames(df) == "CEREALS.UNMILLED_Barley.for.Beer"         ] <- "pkg.bar.bbeer2"
colnames(df)[colnames(df) == "CEREALS.UNMILLED_Hulled.Barley"           ] <- "pkg.bar.temez2"
colnames(df)[colnames(df) == "P.R.I.C.E...I.N....B.I.R.R_Malt.Barley"   ] <- "pkg.bar.maltb2"


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


# now merge data from duplicate cols
df$pkg.bar.white <- ifelse(is.na(df$pkg.bar.white), df$pkg.bar.white2, df$pkg.bar.white)
df$pkg.bar.mixed <- ifelse(is.na(df$pkg.bar.mixed), df$pkg.bar.mixed2, df$pkg.bar.mixed)
df$pkg.bar.black <- ifelse(is.na(df$pkg.bar.black), df$pkg.bar.black2, df$pkg.bar.black)
df$pkg.bar.bbeer <- ifelse(is.na(df$pkg.bar.bbeer), df$pkg.bar.bbeer2, df$pkg.bar.bbeer)
df$pkg.bar.temez <- ifelse(is.na(df$pkg.bar.temez), df$pkg.bar.temez2, df$pkg.bar.temez)
df$pkg.bar.maltb <- ifelse(is.na(df$pkg.bar.maltb), df$pkg.bar.maltb2, df$pkg.bar.maltb)

# drop columns that are now redundant
df <- df[,!(names(df) %in% c("pkg.bar.white2", "pkg.bar.mixed2", "pkg.bar.black2", "pkg.bar.bbeer2",  "pkg.bar.temez2", "pkg.bar.maltb2"))]



# convert text values to standardized values
df[,"Region"] <- stringr::str_to_title(df$Region)
df[,"Market"] <- stringr::str_to_title(df$Market)
df[,"Month"] <- stringr::str_to_sentence(df$Month)

# check spatial & temporal coverage 
unique(df$Region) # need to be encoded
unique(df$Market) # need to be standardized/coded & assigned coordinates
unique(df$Year) # only 2016 & 2017
unique(df$Month) # 

table(df$Year, df$Month, useNA="ifany")


psych::corr.test(df[,-c(1:6)])

# create composite 
df[,"pkg.bar.allba"] <- df$pkg.bar.white
df$pkg.bar.allba <- ifelse(is.na(df$pkg.bar.allba), df$pkg.bar.mixed, df$pkg.bar.allba)
df$pkg.bar.allba <- ifelse(is.na(df$pkg.bar.allba), df$pkg.bar.black, df$pkg.bar.allba)
summary(df$pkg.bar.allba)

write.csv(df, file = "reformatted_pkg_bar_2009_ec.csv")
