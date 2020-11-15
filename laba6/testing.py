from TestDeterminate import TestDeterminate
import utils

def main():
	basePath = '/Users/yura-pc/Files/Study/3курс/1сем/НПО/laba6/'
	pathToDriver = basePath + 'chromedriver'
	pathToData = basePath + 'calcData.xlsx'
	sheetName = 'Лист1'
	link = 'https://matrixcalc.org'

	testObj = TestDeterminate(pathToDriver, pathToData, sheetName, link)
	testObj.startTest()
	results = testObj.endTest()
	utils.analizeResults(results)


if __name__ == '__main__':
	main()