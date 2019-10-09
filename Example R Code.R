
 source('Loran.f.R') 

bar <- function(i, n, size = 60, char = ">", prefix = memory.size())
  {
        num <- round((size * i)/n)
        cat(prefix, " |", paste(rep(char, num), collapse = ""), paste(rep(" ", size - num), collapse = ""),
                "|\r", sep = "")
        flush.console()

        invisible()
  }


# --------------------------------------------------------------------------------------------------------------------


load("Example.Loran.Data.RData")

Example.Loran.Data
   trp.haul STCHAN1 STCHAN2         CHAIN      ptdepart portdelv ptdepart.Lat ptdepart.Long
1      5.10 28280.0 41803.0 5990 Canadian WARRENTON, OR  Astoria         4610         12355
2      5.13 28318.0 41776.0 5990 Canadian WARRENTON, OR  Astoria         4610         12355
3      5.14 28049.0 41845.0 5990 Canadian WARRENTON, OR  Astoria         4610         12355
4      5.16 27982.0 41841.0 5990 Canadian WARRENTON, OR  Astoria         4610         12355
5      5.17 27971.0 41853.0 5990 Canadian WARRENTON, OR  Astoria         4610         12355
6      6.01 12861.9 27874.6 9940 American   NEWPORT, OR  Newport         4438         12403
7      6.02 12933.5 27853.0 9940 American   NEWPORT, OR  Newport         4438         12403
8      6.05 12837.7 27872.2 9940 American   NEWPORT, OR  Newport         4438         12403
9      6.06 12598.5 27867.6 9940 American   NEWPORT, OR  Newport         4438         12403
10     6.07 13002.3 27833.6 9940 American   NEWPORT, OR  Newport         4438         12403
11     6.08 13002.0 27811.9 9940 American   NEWPORT, OR  Newport         4438         12403


# A single call using Loran.f
Loran.f(28280.0, 41803.0, 5990, 4610, 12355)


# Use R to loop over rows:

change(Example.Loran.Data)

LatLong <- NULL

for( i in 1:nrow(Example.Loran.Data)) {
 bar(i, nrow(Example.Loran.Data)) 
 LatLong <- rbind(LatLong, Loran.f(STCHAN1[i], STCHAN2[i], substring(CHAIN[i],1,4), ptdepart.Lat[i], ptdepart.Long[i]))
}
 

# Column bind result 

(Example.Loran.Data.LL <- cbind(Example.Loran.Data, LatLong))






