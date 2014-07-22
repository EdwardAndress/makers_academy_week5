require './lib/water'

describe Water do
	it 'is splashed when shot at' do
		water = Water.new
		expect(water.hit!).to eq 'Splash'
	end
end