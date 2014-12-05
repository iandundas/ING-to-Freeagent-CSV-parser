# ING to Freeagent CSV converter

A very bare-bones script for converting the output of ING's CSV export into a CSV that is able to be imported into FreeagentCentral.com

Assumptions: 
- Running OS X
- Have Ruby installed
- CSV filename is of similar format: `NLxxINGBxxxxxxxxxx_xx-xx-xxxx_xx-xx-xxxx`, which is how ING exports by default. e.g. `NL98INGB1234567890_01-12-2014_04-12-2014`

Instructions: 

1. Download CSV from here https://bankieren.mijn.ing.nl/particulier/overzichten/download/index
2. For "Bestandsformaat", choose Kommagescheiden (dd-mm-jjjj)
3. Download the CSV
4. Then, run the following script on the command line (OS X): 

`./parse-ING-csv.rb [your-filename-here].csv`

The script will output `[your-filename-here]-converted.csv`