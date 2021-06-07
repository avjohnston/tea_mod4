require 'rails_helper'

RSpec.describe 'Api::V1::Subscriptions Create', type: :request do
  before :each do
    @customer = Customer.create!(first_name: 'Andrew', last_name: 'Johnston', email: 'andrew@email.com', address: '123 Denver St')
    @tea = TeaType.create(title: 'green', description: 'so yummy and hot', temperature: 85, brew_time: 3)
  end

  describe 'happy path' do
    it 'should return 201 and create the subscription if the params are valid' do 
      valid_params = {
        customer_id: @customer.id,
        tea_id: @tea.id,
        freq: 'one'
      }
      
      post api_v1_subscriptions_path, params: valid_params

      json = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(201)
      expect(json[:data]).to eq('subscription successfully created')

      expect(@customer.subscriptions.size).to eq(1)
      expect(@customer.subscriptions[0].customer_id).to eq(@customer.id)
      expect(@customer.subscriptions[0].tea_type_id).to eq(@tea.id)
      expect(@customer.subscriptions[0].title).to eq(@tea.title.upcase)
      expect(@customer.subscriptions[0].status).to eq('active')
      expect(@customer.subscriptions[0].frequency).to eq('one')
    end 
  end 

  describe 'sad path' do 
    it 'should raise error if customer or tea id are invalid' do 
      invalid_params = {
        customer_id: 1000000,
        tea_id: @tea.id,
        freq: 'one'
      }
      invalid_params2 = {
        customer_id: @customer.id,
        tea_id: 1000000,
        freq: 'one'
      }

      expect{post api_v1_subscriptions_path, params: invalid_params}.to raise_error(ActiveRecord::RecordNotFound)
      expect{post api_v1_subscriptions_path, params: invalid_params2}.to raise_error(ActiveRecord::RecordNotFound)
    end
    
    it 'invalid frequency should return invalid frequency' do 
      invalid_params = {
        customer_id: @customer.id,
        tea_id: @tea.id,
        freq: 'ten'
      }

      post api_v1_subscriptions_path, params: invalid_params

      json = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(400)
      expect(json[:error]).to eq('invalid parameters')
    end

    it 'should return missing param if no frequency' do 
      invalid_params = {
        customer_id: @customer.id,
        tea_id: @tea.id
      }

      post api_v1_subscriptions_path, params: invalid_params

      json = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(400)
      expect(json[:error]).to eq('missing freq param(s)')
    end
    
    it 'should raise error if no customer or tea id param' do 
      invalid_params = {
        tea_id: @tea.id,
        freq: 'one'
      }
      invalid_params2 = {
        customer_id: @customer.id,
        freq: 'one'
      }

      expect{post api_v1_subscriptions_path, params: invalid_params}.to raise_error(ActiveRecord::RecordNotFound)
      expect{post api_v1_subscriptions_path, params: invalid_params2}.to raise_error(ActiveRecord::RecordNotFound)
    end 
  end 
end