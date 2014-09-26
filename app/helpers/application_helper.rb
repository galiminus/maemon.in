module ApplicationHelper
  def on_home?
    p params
    params[:controller] == 'pages' && params[:id] == 'home'
  end
end
