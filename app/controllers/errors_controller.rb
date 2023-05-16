class ErrorsController < ApplicationController
  def not_found
    render status: 404
  end

  def unprocessable
    render status: 422
  end

  def internal
    rendes status: 500
  end
end
