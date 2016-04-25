class ApplicationController < ActionController::API
  include ActionController::Serialization
  respond_to :html, :json

  def default_serializer_options
    {root: false}
  end

end
