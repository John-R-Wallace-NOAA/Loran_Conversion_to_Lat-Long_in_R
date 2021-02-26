
source('Loran.f.R') 

bar <- function(i, n, size = 60, char = ">", prefix = memory.size())
{
     num <- round((size * i)/n)
     cat(prefix, " |", paste(rep(char, num), collapse = ""), paste(rep(" ", size - num), collapse = ""),
             "|\r", sep = "")
     flush.console()

     invisible()
}

scanIn <- function (text, header = TRUE, ncol = 2, matrix = TRUE, numeric = FALSE) 
{
    if(matrix) {
        Out <- data.frame(matrix(scan(what = "", text = text, quiet = TRUE), 
              ncol = ncol, byrow = TRUE), stringsAsFactors = FALSE)
        if (header) {
            names(Out) <- as.character(Out[1, ])
            Out <- Out[-1, ]
        }
        Out <- JRWToolBox::renum(Out)
     } else {
        if(numeric)
            Out <- scan(text = text, quiet = TRUE)
        else 
            Out <- scan(what = "", text = text, quiet = TRUE)        
     }          
     Out
}


# --------------------------------------------------------------------------------------------------------------------


# load("Example.Loran.Data.RData")

# Example.Loran.Data
(Example.Loran.Data <- scanIn("
   trp.haul STCHAN1 STCHAN2         CHAIN      ptdepart     ptdepart.Lat ptdepart.Long
       5.10 28280.0 41803.0 '5990 Canadian' 'WARRENTON, OR'         4610         12355
       5.13 28318.0 41776.0 '5990 Canadian' 'WARRENTON, OR'         4610         12355
       5.14 28049.0 41845.0 '5990 Canadian' 'WARRENTON, OR'         4610         12355
       5.16 27982.0 41841.0 '5990 Canadian' 'WARRENTON, OR'         4610         12355
       5.17 27971.0 41853.0 '5990 Canadian' 'WARRENTON, OR'         4610         12355
       6.01 12861.9 27874.6 '9940 American'   'NEWPORT, OR'         4438         12403
       6.02 12933.5 27853.0 '9940 American'   'NEWPORT, OR'         4438         12403
       6.05 12837.7 27872.2 '9940 American'   'NEWPORT, OR'         4438         12403
       6.06 12598.5 27867.6 '9940 American'   'NEWPORT, OR'         4438         12403
       6.07 13002.3 27833.6 '9940 American'   'NEWPORT, OR'         4438         12403
       6.08 13002.0 27811.9 '9940 American'   'NEWPORT, OR'         4438         12403
"))
Example.Loran.Data$trp.haul <- as.numeric(Example.Loran.Data$trp.haul)
Example.Loran.Data$STCHAN1 <- as.numeric(Example.Loran.Data$STCHAN1)
Example.Loran.Data$STCHAN2 <- as.numeric(Example.Loran.Data$STCHAN2)
Example.Loran.Data$ptdepart.Lat <- as.numeric(Example.Loran.Data$ptdepart.Lat)
Example.Loran.Data$ptdepart.Long <- as.numeric(Example.Loran.Data$ptdepart.Long)


# A single call using Loran.f
Loran.f(28280.0, 41803.0, 5990, 4610, 12355)


# Use R to loop over rows
attach(Example.Loran.Data)

LatLong <- NULL

for( i in 1:nrow(Example.Loran.Data)) {
   bar(i, nrow(Example.Loran.Data)) 
   LatLong <- rbind(LatLong, Loran.f(STCHAN1[i], STCHAN2[i], substring(CHAIN[i],1,4), ptdepart.Lat[i], ptdepart.Long[i]))
}

# Column bind result 
(Example.Loran.Data.LL <- cbind(Example.Loran.Data, LatLong))

# Cleanup
detach(2)




