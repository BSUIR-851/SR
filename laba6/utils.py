from openpyxl import load_workbook

def fillMatrix(elements):
	matrix = []
	try:
		dim = int(len(elements) ** (1/2))
	except:
		dim = 3

	m = 0
	for i in range(dim):
		tempMatrix = []
		for j in range(dim):
			tempMatrix.append(elements[m])
			m += 1
		matrix.append(tempMatrix)

	return matrix

def getData(path, sheet):
	book = load_workbook(path, data_only=True)
	sheet = book[sheet]
	matrices, dets = [], []
	for row in sheet.rows:
		matrixElements = []
		for elem in row:
			matrixElements.append(elem.value)
		matrix = fillMatrix(matrixElements[0:-1])
		matrices.append(matrix)
		dets.append(matrixElements[-1])

	return matrices, dets

def analizeResults(results):
	print('=============================')
	print('Format: number || result || expected || real\n')
	
	for i in range(len(results)):
		result = results[i]
		expected = result['expected']
		real = result['real']
		outputString = str(i) + ' || ' + str(expected == real) + ' || ' + str(expected) + ' || ' + str(real)
		print(outputString)

	print('=============================')


