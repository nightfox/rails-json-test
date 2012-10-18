class UserController < ApplicationController


  before_filter :cors_set_access_control_headers

  # For all responses in this controller, return the CORS access control headers.

  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers['Access-Control-Max-Age'] = "1728000"
  end

  def index


    respond_to do |format|
      format.json do
        if params[:year].blank?
          users_2010 = User.where(year_of_joining: 2010).limit(10)
          users_2011 = User.where(year_of_joining: 2011).limit(10)
          users_2009 = User.where(year_of_joining: 2009).limit(10)
          users = {2009 => [],2010 => [],2011=> []}
          users_2009.each{|u| users[2009] << u}
          users_2010.each{|u| users[2010] << u}
          users_2011.each{|u| users[2011] << u}
          json_users = users
        else
          users = Array.new
          User.where(year_of_joining: params[:year]).each {|u| users << u}
          json_users = users
        end
         render(json: {users: json_users})
      end
    end
  end
end
