class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  def render_unprocessable_entity_response
    render json: exception.record.errors, status: 404
  end

  def invalid_params
    render json: {error: 'invalid parameters'}, status: 400
  end

  def missing_params(params)
    render json: {error: "missing #{params.to_sentence} param(s)"}, status: 400
  end
end
