class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_account_update_params, only: [:update]
  Profile_params = [:profile_photo, :profile_photo_cache, :remove_profile_photo].freeze

  protected

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [Profile_params])
  end

  def update_resource(resource, params)
    resource.update_without_current_password(params)
  end

  def after_update_path_for(resource)
    user_path(resource)
  end
end
