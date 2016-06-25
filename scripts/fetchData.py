from __future__ import print_function
from lxml import html
import requests
import csv

# You need to be a part of the IITB network to be able to run this script
USERNAME = # Your username
PASSWORD = # Your password
BASE_URL = 'http://lists.iitb.ac.in/pipermail/student-notices/'

# Get links corresponding to every quarter from the homepage
pageRoot = requests.get(BASE_URL, verify=False, auth=(USERNAME, PASSWORD))
treeRoot = html.fromstring(pageRoot.content)
quarters = treeRoot.xpath('//table/tr/td[3]/a/@href')

# Setup output file writers
outputFile = open("../data/rawData.csv", "w")
writer = csv.writer(outputFile)

count = 0
countQtr = 0

for quarter in quarters[26:]:
	print("Quarter number ", countQtr, quarter)
	countQtr += 1

	# Get quarter as 'yyyyqn'
	quarter = quarter[:6] + '/'

	# Get the page that shows emails of a particular quarter, extract the link of every email
	pageQtr = requests.get(BASE_URL + quarter + 'thread.html', verify=False, auth=(USERNAME, PASSWORD))
	treeQtr = html.fromstring(pageQtr.content)
	filenames = treeQtr.xpath('//li/a/@href')
	data = []

	for file in filenames[3:-3]:
		# print(file)
		count += 1

		if(count % 10 == 0):
			print(count)

		# Get webpage corresponding to every email
		page = requests.get(BASE_URL + quarter + file, verify=False, auth=(USERNAME, PASSWORD))
		tree = html.fromstring(page.content)

		# Get relevant sections from the email
		sub = [tree.xpath('//body/h1/text()')[0].encode('utf-8')]
		sender = [tree.xpath('//body/b/text()')[0].encode('utf-8')]
		time = tree.xpath('//body/i/text()')[0].split()
		time[1] = time[1] + " " + time[2]
		time.pop(2)
		# text = tree.xpath('//body/pre/text()')

		# Write data to the file
		sub = [quarter[:-1]] + [file[:-5]] + sub
		sub += sender
		sub += time
		# print(sub)
		writer.writerows([sub])