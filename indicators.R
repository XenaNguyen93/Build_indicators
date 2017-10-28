#Author: Giang Nguyen
setwd("~/GiangG/NuvestCapital") 
library(quantmod)
data_world <- new.env()
tickers = c("SPY", "IEMG")
for (value in tickers){
  print(value)
  getSymbols(value, src = 'yahoo', env = data_world, from = as.Date('2017-06-11'), to = as.Date('2017-10-11'), auto.assign = T)
}
SPY_data <- as.data.frame(get("SPY", envir = data_world), check.rows = TRUE)

IEMG_data <- as.data.frame(get("IEMG", envir = data_world),check.rows = TRUE)

#SPY_rsi and IEMG_rsi
SPY_rsi <- as.data.frame(RSI(SPY_data[,c("SPY.Close")]))
IEMG_rsi <- as.data.frame(RSI(IEMG_data[,c("IEMG.Close")]))
rsi <- merge(SPY_rsi,IEMG_rsi, all.x = TRUE, all.y = TRUE)
rsi[length(rsi)+1] <- rownames(rsi)
colnames(rsi)[length(rsi)] <- "index"

#SPY_bb and IEMG_bb
SPY_bb <- as.data.frame(BBands(SPY_data[,c("SPY.Close")]))
IEMG_bb <- as.data.frame(BBands(IEMG_data[,c("IEMG.Close")]))
bb <- merge(SPY_bb,IEMG_bb, all.x = TRUE, all.y = TRUE)
bb[length(bb)+1] <- rownames(bb)
colnames(bb)[length(bb)] <- "index"

#SPY_ema_15 and IEMG_ema_15
spy_ema_15 <- as.data.frame(EMA(SPY_data[,c("SPY.Close")],n = 15))
iemg_ema_15 <- as.data.frame(EMA(IEMG_data[,c("IEMG.Close")],n = 15))
ema_15 <- merge(spy_ema_15,iemg_ema_15 ,all.x = TRUE, all.y = TRUE)
ema_15[length(ema_15)+1] <- rownames(ema_15)
colnames(ema_15)[length(ema_15)] <- "index"

#spy_ema_35 and iemg_ema_35
spy_ema_35 <- as.data.frame(EMA(SPY_data[,c("SPY.Close")],n = 35))
iemg_ema_35 <- as.data.frame(EMA(IEMG_data[,c("IEMG.Close")],n = 35))
ema_35 <- merge(spy_ema_35,iemg_ema_35, all.x = TRUE, all.y = TRUE)
ema_35[length(ema_35)+1] <- rownames(ema_35)
colnames(ema_35)[length(ema_35)] <- "index"


result <- merge(merge(rsi, bb, by="index", all.x = T, all.y = T),merge(ema_15, ema_35, by="index", all.x = T, all.y = T),
                by="index", all.x = T, all.y = T)
write.csv(result, "thrid.csv")


