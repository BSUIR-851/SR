from selenium import webdriver
from selenium.webdriver.common.keys import Keys 
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

from bs4 import BeautifulSoup as BS

import utils

class TestDeterminate():
	def __init__(self, pathToDriver, pathToData, sheetName, link):
		self.driver = webdriver.Chrome(pathToDriver)
		self.pathToData = pathToData
		self.sheetName = sheetName
		self.link = link
		self.results = []

	def getMatricesAndDetsFromExcel(self):
		matrices, dets = utils.getData(self.pathToData, self.sheetName)
		return matrices, dets

	def getResultDeterminate(self):
		soup = BS(self.driver.page_source, 'html.parser')
		texts = soup.find('section', {'id': 'resdiv'}).find('ol').find('li').find('math').find_all('mn')
		res = texts[-1].get_text()
		if texts[-1].previousSibling.get_text() != '=':
			res = '-' + res
		try:
			det = int(res)
		except:
			det = 0
		return det

	def execTest(self, matrix, det):
		for i in range(len(matrix)):
			for j in range(len(matrix[i])):
				elem = self.driver.find_element_by_id('A-' + str(i) + '-' + str(j))
				elem.clear()
				elem.send_keys(str(matrix[i][j]))

		elem = self.driver.find_element_by_css_selector('button[data-expression="determinant A"]')
		elem.click()

		testRes = {
			'expected': det,
			'real': self.getResultDeterminate(),
		}
		
		return testRes

	def startTest(self):
		matrices, dets = self.getMatricesAndDetsFromExcel()

		self.driver.get(self.link)

		for i in range(len(matrices)):
			testRes = self.execTest(matrices[i], dets[i])
			self.results.append(testRes)


	def endTest(self):
		self.driver.close()
		return self.results














