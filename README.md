The R function, 'Loran.f', uses the 32-bit DOS executable 'GPTOTD.EXE' to convert Loran coordinates to lat/long in R.

The 'Example R Code.R' script has looping software to allow conversion of large data sets. 

For GPTOTD.EXE go to:

   https://www.loran.org/software.htm  ('GP to TD Zip' under Program Files).
    
 Keep the 3 DATUM files (FWGS84, FWGS72, FNAD) in the same folder as GPTOTD.EXE. 
    
To get a free 32-bit Windows XP virtual machine to run on your 64-bit box see:

   https://www.makeuseof.com/tag/download-windows-xp-for-free-and-legally-straight-from-microsoft-si/
   
Update: WindowsXPMode_en-us.exe as of 26 Feb 2021 can be found here:

  https://download.cnet.com/Windows-XP-Mode/3001-18513_4-77683344.html   
   

The R version 2.12.2 will install into the 32-bit Windows XP enviroinment and run the code provided:

   https://cran-archive.r-project.org/bin/windows/base/old/2.12.2/
