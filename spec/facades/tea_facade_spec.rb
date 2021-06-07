require 'rails_helper'

RSpec.describe TeaFacade, type: :model do
  describe 'class methods' do 
    it '#tea_db_flood', :vcr do 
      expect(TeaType.all.size).to eq(0)

      TeaFacade.tea_db_flood

      expect(TeaType.all.size).to eq(12)
      
      tea = TeaType.first

      expect(tea.title).to be_a(String)
      expect(tea.description).to be_a(String)
      expect(tea.temperature).to be_an(Integer)
      expect(tea.brew_time).to be_an(Integer)
    end
  end
end