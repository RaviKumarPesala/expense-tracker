class ApplicationController < ActionController::API
  before_action :authenticate_request

  def authenticate_request
    headers['api-key'] = 'et-api'
    headers['role'] = 'admin'
  end
end
