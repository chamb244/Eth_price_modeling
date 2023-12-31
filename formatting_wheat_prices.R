

setwd("C:/DATA/Ethiopia/price_modeling/Kevin/EthPriceModelling/output/ETHPriceData/")
list.files()
df <- read.csv("8. Retail price 2011 E.C_wheat.csv")
df <- df[-c(1,3),-c(1)]
summary(df)
sapply(df, class) 

names(df)

colnames(df)[colnames(df) == "X01.1.FOOD_Bread.Wheat..Bakery."] <- "pkg.wht.bread"
colnames(df)[colnames(df) == "X01.1.1.2.UNMILLED.CEREALS.GRAINS_Wheat.White"] <- "pkg.wht.white"
colnames(df)[colnames(df) == "X01.1.1.2.UNMILLED.CEREALS.GRAINS_Wheat.Mixed"] <- "pkg.wht.mixed"
colnames(df)[colnames(df) == "X01.1.1.2.UNMILLED.CEREALS.GRAINS_Wheat.Black..Red."] <- "pkg.wht.blred"
colnames(df)[colnames(df) == "X01.1.1.2.UNMILLED.CEREALS.GRAINS_Emmer.Wheat..shelled..Aja"] <- "pkg.wht.shaja"
colnames(df)[colnames(df) == "X01.1.1.2.UNMILLED.CEREALS.GRAINS_Emmer.Wheat..unshelled."] <- "pkg.wht.unshe"
colnames(df)[colnames(df) == "CEREALS.MILLED_Wheat.White"] <- "pkg.wht.millw"
colnames(df)[colnames(df) == "CEREALS.MILLED_Wheat.Mixed"] <- "pkg.wht.millm"            
colnames(df)[colnames(df) == "CEREALS.MILLED_Emmer.Wheat.Aja."] <- "pkg.wht.milla"             
colnames(df)[colnames(df) == "X01.2.1.1.COFFEE.AND.TEA_Malt.Wheat"] <- "pkg.wht.maltw"
colnames(df)[colnames(df) == "P.R.I.C.E...I.N....B.I.R.R_Porridge..bula..or.wheat"] <- "pkg.wht.pbula"

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


# check spatial & temporal coverage 
unique(df$Region) # need to be encoded
unique(df$Market) # need to be standardized/coded & assigned coordinates
unique(df$Year) # only 2018 & 2019
unique(df$Month) # missing June


# check means and pair-wise correlation between different wheat grain prices
summary(df[,c("pkg.wht.white", "pkg.wht.mixed", "pkg.wht.blred")])
cor(df[,c("pkg.wht.white", "pkg.wht.mixed", "pkg.wht.blred")], use = "complete.obs")


# create composite 
df[,"pkg.wht.allwh"] <- df$pkg.wht.white
df$pkg.wht.allwh <- ifelse(is.na(df$pkg.wht.allwh), df$pkg.wht.blred, df$pkg.wht.allwh)
df$pkg.wht.allwh <- ifelse(is.na(df$pkg.wht.allwh), df$pkg.wht.mixed, df$pkg.wht.allwh)
summary(df$junk)
