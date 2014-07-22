require './lib/coordinates'

describe Coordinates do

	it 'can take some coordinates' do
		coordinates = Coordinates.new(['A1'])
		expect(coordinates.locations).to eq ['A1']
	end

	context 'must be inside the grid' do
		it 'knows if a location is included in the grid range' do
			coordinates = Coordinates.new(['A1'])
			expect(coordinates).to be_inside_grid
		end

		it 'separates the coordinates' do
			coordinates = Coordinates.new(['A1'])
			expect(coordinates.columns).to eq ['A']
			expect(coordinates.rows).to eq [1]
		end

		it 'separates multiple coordinates' do
			coordinates = Coordinates.new(['A1', 'B2', 'C3'])
			expect(coordinates.columns).to eq ['A', 'B', 'C']
			expect(coordinates.rows).to eq [1,2,3]
		end

		it 'knows if a location is not included in the grid range' do
			coordinates = Coordinates.new(['K12'])
			expect(coordinates).not_to be_inside_grid
		end
	end

	context 'must be sequential' do
		it 'knows that [1, 2, 3] are sequential' do
			coordinates = Coordinates.new(['A1', 'A3', 'A2'])
			expect(coordinates.rows_sequential?).to be true
		end

		it 'knows that ["A", "C", "D"] are not sequential' do
			coordinates = Coordinates.new(['A', 'C', 'D'])
			expect(coordinates.columns_sequential?).to be false
		end

		it 'knows that ["A", "C", "B"] are sequential' do
			coordinates = Coordinates.new(['A', 'C', 'B'])
			expect(coordinates.columns_sequential?).to be true
		end
	end

	context 'checking validity' do
		it 'knows that ["A1", "A2", "A4"] are not valid coordinates' do
			coordinates = Coordinates.new(["A1", "A2", "A4"])
			expect(coordinates).not_to be_valid
		end

		it 'knows that ["A1", "A2", "A3"] are valid coordinates' do
			coordinates = Coordinates.new(["A1", "A2", "A3"])
			expect(coordinates).to be_valid
		end

		it 'knows that ["C1", "D1", "E1"] are valid coordinates' do
			coordinates = Coordinates.new(["C1", "D1", "E1"])
			expect(coordinates).to be_valid
		end
	end

end