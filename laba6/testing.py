from selenium import webdriver
from selenium.webdriver.common.keys import Keys 
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

from bs4 import BeautifulSoup as BS
import time

class testDeterminate():
	def __init__(self, pathToDriver, pathToData, link):
		self.driver = webdriver.Chrome(pathToDriver)
		self.pathToData = pathToData
		self.link = link

	def getMatrixAndDetFromExcel(self):
		# do later

		matrix = [
			[1, 92, 3],
			[6, -2, 8],
			[2, 7, -9],
		];
		det = 6540
		return matrix, det

	def getResultDeterminate(self):
		soup = BS(self.driver.page_source, 'html.parser')
		texts = soup.find('section', {'id': 'resdiv'}).find('ol').find('li').find('math').findAll('mn')
		try:
			det = int(texts[-1].get_text())
		except:
			det = 0
		return det

	def startTest(self):
		matrix, det = self.getMatrixAndDetFromExcel()
		# self.driver.implicitly_wait(3)
		self.driver.get(self.link)

		for i in range(len(matrix)):
			for j in range(len(matrix[i])):
				elem = self.driver.find_element_by_id('A-' + str(i) + '-' + str(j))
				elem.clear()
				elem.send_keys(str(matrix[i][j]))

		elem = self.driver.find_element_by_css_selector('button[data-expression="determinant A"]')
		elem.click()

		self.results = [self.getResultDeterminate()]


	def endTest(self):
		self.driver.close()
		return self.results


def main():
	basePath = '/Users/yura-pc/Files/Study/3курс/1сем/НПО/laba6/'
	pathToDriver = basePath + 'chromedriver'
	pathToData = basePath + 'calcData.xlsx'
	link = 'https://matrixcalc.org'

	testObj = testDeterminate(pathToDriver, pathToData, link)
	testObj.startTest()
	results = testObj.endTest()
	print(results)


if __name__ == '__main__':
	main()