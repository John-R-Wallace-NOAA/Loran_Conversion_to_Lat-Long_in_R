Loran.f <- function(STCHAN1, STCHAN2, CHAIN, ptdepart.Lat, ptdepart.Long) {

 # *********** GPTOTD.EXE (called by Loran.bat) only works under 32-bit Windows XP or similar (a 32 virtual machine on a 64-bit OS works fine) ***************

 # See: https://www.loran.org/software.htm for the software (GP to TD Zip)
 
 # Canadian Chain
  if(CHAIN == 5990) {

     CHAIN1 <- paste(5990, c("X","Y","Y","Z")[(round(floor(STCHAN1/10000)))], sep="")
     CHAIN2 <- paste(5990, c("X","Y","Y","Z")[(round(floor(STCHAN2/10000)))], sep="")
   }

 # U.S. West Coast      
   if(CHAIN == 9940) {

     CHAIN1 <- paste(9940, c("W","X","", "Y")[(round(floor(STCHAN1/10000)))], sep="")
     CHAIN2 <- paste(9940, c("W","X","", "Y")[(round(floor(STCHAN2/10000)))], sep="")
   }

 shell("echo 3 > LoranIn.txt")
 shell("echo 1 >> LoranIn.txt")

 if(STCHAN1 < STCHAN2) {

    shell(paste("echo ", CHAIN1, " >> LoranIn.txt", sep=""))
    shell(paste("echo ", CHAIN2, " >> LoranIn.txt", sep=""))
    shell("echo 2 >> LoranIn.txt")
    shell(paste("echo ", ptdepart.Lat[1], "N", " ", ptdepart.Long[1], "W", " ", formatC(STCHAN1[1], 2, format='f'), " ", formatC(STCHAN2[1], 2, format='f'), " >> LoranIn.txt", sep=""))


  } else {

    shell(paste("echo ", CHAIN2, " >> LoranIn.txt", sep=""))
    shell(paste("echo ", CHAIN1, " >> LoranIn.txt", sep=""))
    shell("echo 2 >> LoranIn.txt")
    shell(paste("echo ", ptdepart.Lat[1], "N", " ", ptdepart.Long[1], "W", " ", formatC(STCHAN2[1], 2, format='f'), " ", formatC(STCHAN1[1], 2, format='f'), " >> LoranIn.txt", sep=""))

  }
 
 shell("echo 4 >> LoranIn.txt")
 
 write("type LoranIn.txt | GPTOTD.EXE > LoranOut.txt", file = 'Loran.bat')
 system("Loran.bat", show.output.on.console = FALSE)

 LatLong <- scan("LoranOut.txt", what="", skip=41, nlines=1, quiet = T)[3:8]
 LatLong[3] <- substring(LatLong[3], 1, nchar(LatLong[3]) - 1)
 LatLong[6] <- substring(LatLong[6], 1, nchar(LatLong[6]) - 1)
 LatLong <- as.numeric(LatLong)

 data.frame(Lat.DD = LatLong[1] + LatLong[2]/60 + LatLong[3]/3600, Long.DD = LatLong[4] + LatLong[5]/60 + LatLong[6]/3600)

}


