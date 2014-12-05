#!/usr/bin/env ruby

require 'csv'
require 'date'

# Ian Dundas 2014 - https://github.com/iandundas/ING-to-Freeagent-CSV-parser
# See README for more details
# Download CSV from here https://bankieren.mijn.ing.nl/particulier/overzichten/download/index
# Format : Kommagescheiden (dd-mm-jjjj)

filename= ARGV[0] # e.g. "NL98INGB1111111111_01-12-2014_04-12-2014.csv"
filename_regex= /NL\d\dINGB\d{10}_\d\d-\d\d-\d{4}_\d\d-\d\d-\d{4}.csv/

unless filename =~ filename_regex && filename.length == 44
	p "Input filename format not recognised"
	exit
end

filename_sansextension= filename.sub(/.csv/, "")

csv_rows = CSV.read(filename, {:headers => true})

CSV.open(filename_sansextension + "-converted.csv", "wb") do |csv|
	csv_rows.each do |row|
		
		date = Date.parse(row["Datum"]).strftime("%d/%m/%Y")
		amount = row["Bedrag (EUR)"].sub(/,/, ".")
		type = row["Af Bij"]
		
		if type.eql?"Bij"
			amount = Float(amount)
		elsif type.eql?"Af"
			amount = Float(amount) * -1
		else 
			p "ERROR: #{type}"
			exit
		end

		description = "[#{row["MutatieSoort"]}]: #{row["Mededelingen"]}"[0,125]
		csv << [date, amount, description]
	end
end