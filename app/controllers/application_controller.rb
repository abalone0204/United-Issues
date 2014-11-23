class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :get_classification
  before_action :get_country_classification
  before_action :set_request_environment
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to root_url
  end
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    if resource.sign_in_count == 1
      help_path
    else
      request.env['omniauth.origin'] || stored_location_for(resource) || root_path
    end
  end

  def new_session_path(scope)
    new_user_session_path
  end

  def get_statistics_data(posts)
    @data_arr = posts.group_by{ |s| [s.classification, s.country_classification] }.map {|k,v| [k.first.text, k.last.text, v.length]}
    @classification_titles_key = Post.classification.options.map{|p| p}
    @country_titles_key = Post.country_classification.options.map{|p| p}
  end

  private

  # stores parameters for current request
  def set_request_environment
    User.current = current_user # current_user is set by restful_authentication
    # You would also set the time zone for Rails time zone support here:
    # Time.zone = Person.current.time_zone
  end

  protected

  def get_country_classification
    @country_classifications = Post.country_classification.options
  end

  def get_classification
    @classifications = Post.classification.options
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:name, :email, :avatar,:password, :password_confirmation, :provider, :uid)
    end
    # devise_parameter_sanitizer.for(:sign_up) << :name
  end
end
