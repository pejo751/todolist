class CompaniesController < InheritedResources::Base
  before_action :authenticate_user!

private

  def permitted_params
      params.permit(company: [:name])
  end
end
