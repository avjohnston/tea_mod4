require 'rails_helper'

RSpec.describe 'Api::V1::Customers Show', type: :request do
  before :each do 
    @customer = Customer.create!(first_name: 'Andrew', last_name: 'Johnston', email: 'andrew@email.com', address: '123 Denver St')
    @tea = TeaType.create(title: 'green', description: 'so yummy and hot', temperature: 85, brew_time: 3)
    @sub = Subscription.create!(title: @tea.title, price: 3.00, frequency: 'one', customer_id: @customer.id, tea_type_id: @tea.id)
  end
  

  describe 'happy path' do 
    it 'should return a 200 status with the correct information given a valid id' do 
      get api_v1_customer_path(@customer)

      json = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(200)

      expect(json[:data]).to be_a(Hash)
      expect(json[:data][:type]).to eq('customer')
      attr = %i[first_name last_name email address subscriptions]
      expect(json[:data][:attributes].keys).to eq(attr)
      expect(json[:data][:attributes].keys).to eq(attr)
      expect(json[:data][:attributes][:first_name]).to eq(@customer.first_name)
      expect(json[:data][:attributes][:last_name]).to eq(@customer.last_name)
      expect(json[:data][:attributes][:email]).to eq(@customer.email)
      expect(json[:data][:attributes][:address]).to eq(@customer.address)
      subs = json[:data][:attributes][:subscriptions]
      expect(subs.size).to eq(1)
      expect(subs[0][:title]).to eq(@sub.title)
      expect(subs[0][:price]).to eq(@sub.price)
      expect(subs[0][:frequency]).to eq(@sub.frequency)
      expect(subs[0][:tea_type_id]).to eq(@tea.id)
      expect(subs[0][:customer_id]).to eq(@customer.id)
    end 
  end 

  describe 'sad path' do 
    it 'should raise error if id doesnt match a customer' do 
      expect{get api_v1_customer_path(100000000)}.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end