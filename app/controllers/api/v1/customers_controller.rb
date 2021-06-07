class Api::V1::CustomersController < ApplicationController
  def show
    @customer = Customer.find(params[:id])
    @serial = CustomerSerializer.new(@customer)

    render json: @serial
  end
end