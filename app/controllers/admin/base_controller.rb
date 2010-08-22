class Admin::BaseController < ApplicationController
  ADMIN_NAME, ADMIN_PASSWORD = "ssf_admin", "a24.12.iW"
#  before_filter :guard_admin_area if RAILS_ENV.eql?('production')

  private

  def guard_admin_area
    authenticate_or_request_with_http_basic('Administration') do |user_name, password|
      user_name == ADMIN_NAME && password == ADMIN_NAME
    end
  end

end
