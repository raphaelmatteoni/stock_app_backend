module ErrorHandlingConcern
  extend ActiveSupport::Concern

  included do
    rescue_from StandardError, with: :internal_server_error
  end

  private

  def internal_server_error(exception)
    render json: { error: exception.message }, status: :internal_server_error
  end
end
