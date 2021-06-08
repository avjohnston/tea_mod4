class Api::V1::SubscriptionsController < ApplicationController
  def create
    @customer = Customer.find(params[:customer_id])
    @tea = TeaType.find(params[:tea_id])

    return missing_params(['freq']) if !params[:freq]
    return invalid_params if !['one', 'two', 'four'].include?(params[:freq])
    @customer.subscriptions.create(title: @tea.title.upcase, price: rand(5..10), frequency: params[:freq], tea_type_id: @tea.id)

    render json: {data: 'subscription successfully created'}, status: 201
  end

  def update
    @sub = Subscription.find(params[:id])
    @sub.update(status: 'cancelled')

    render json: {data: 'subscription successfully cancelled'}, status: 200
  end
end