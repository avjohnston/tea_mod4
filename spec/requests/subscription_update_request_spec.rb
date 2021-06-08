require 'rails_helper'

RSpec.describe 'Api::V1:: Update', type: :request do
  before :each do
    @customer = Customer.create!(first_name: 'Andrew', last_name: 'Johnston', email: 'andrew@email.com', address: '123 Denver St')
    @tea = TeaType.create(title: 'green', description: 'so yummy and hot', temperature: 85, brew_time: 3)
    @sub = Subscription.create!(title: @tea.title, price: 3.00, frequency: 'one', customer_id: @customer.id, tea_type_id: @tea.id)
  end

  describe 'happy path' do 
    it 'should return 204 given valid params' do
      patch api_v1_subscription_path(@sub.id)

      json = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(200)
      expect(json[:data]).to eq('subscription successfully cancelled')

      subscription = Subscription.find(@sub.id)
      expect(subscription.status).to eq('cancelled')
    end 
  end 

  describe 'sad path' do 
    it 'should raise an error if the sub id is invalid' do 
      patch api_v1_subscription_path(1000000)
      json = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(404)
      expect(json[:error]).to eq('record not found')

      patch api_v1_subscription_path
      json2 = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(404)
      expect(json2[:error]).to eq('record not found')
    end 
  end 
end