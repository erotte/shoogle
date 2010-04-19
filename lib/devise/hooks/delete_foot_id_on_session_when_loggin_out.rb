Warden::Manager.before_logout do |record, warden, scope|
  warden.response.session[:foot_id] = nil
end