class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception


  protected
  def redirect_some_path_unless_role some_path, role #przekierowaie gdzies jezeli user nie ma podanej roli
    redirect_to some_path unless current_user and current_user.role == role
  end

end
