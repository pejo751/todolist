class RegistrationsControllerr < Devise::RegistrationsController

  def new
  end

private

  def permitted_params
      params.permit(user: [:email, :password, :password_confirmation,
        company_attributes: [:name]]
      )
  end

end



  # def create
  #   resource = build_resource(params[:user])

  #   if(resource.save)
  #     sign_in(resource_name, resource)
  #     respond_with resource, :location => after_sign_up_path_for(resource)
  #   else
  #     render :action => "new"
  #   end


  # end

  # def update
  #   super
  # end