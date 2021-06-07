require 'rails_helper'

RSpec.describe TeaService, type: :model do
  describe 'class methods' do 
    it '#get_all_teas', :vcr do
      response = TeaService.get_all_teas
      attr = %i[_id name image description keywords origin brew_time temperature comments __v]

      expect(response.size).to eq(12)
      expect(response[0].keys).to eq(attr)
      expect(response[0][:name]).to be_a(String)
      expect(response[0][:image]).to be_a(String)
      expect(response[0][:description]).to be_a(String)
      expect(response[0][:keywords]).to be_a(String)
      expect(response[0][:origin]).to be_a(String)
      expect(response[0][:brew_time]).to be_an(Integer)
      expect(response[0][:temperature]).to be_an(Integer)
      expect(response[0][:comments]).to be_an(Array)
    end 
  end
end