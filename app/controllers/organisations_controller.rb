class OrganisationsController < ApplicationController
  respond_to :html, :json
  respond_to :js, only: :index

  def index
    @organosations = Organisation.order_by_contributions.page(params[:page])
    respond_with @organisations
  end

  def show
    @organisation = Organisation.find_by_login!(params[:id])
    respond_with @organisation
  end
end
