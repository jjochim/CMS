class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  $movie_front_side = []
  $seance_front_side = []

  protected
  def redirect_some_path_unless_role some_path, role #przekierowaie gdzies jezeli user nie ma podanej role
    redirect_to some_path unless current_user and current_user.role == role[0]
  end

  def redirect_some_path_unless_roles some_path #przekierowaie gdzies jezeli user nie jest zalogowany
    redirect_to some_path unless current_user
  end

  def redirect_if_movie_not_in_front_side user
    user ||= User.new
    if user.role != 'admin'
      redirect_to root_path unless ($movie_front_side.include? params[:id].to_i)
    end
  end

  def redirect_if_seance_not_in_front_side user
    user ||= User.new
    if user.role != 'admin'
      redirect_to root_path unless ($seance_front_side.include? params[:seance_id].to_i)
    end
  end

end
