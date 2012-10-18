class UserController < ApplicationController

  def index
    if params[:year].blank?
      users_2010 = User.where(year_of_joining: 2010).limit(10)
      users_2011 = User.where(year_of_joining: 2011).limit(10)
      users_2009 = User.where(year_of_joining: 2009).limit(10)
      users = {2009 => [],2010 => [],2011=> []}
      users_2009.each{|u| users[2009] << u}
      users_2010.each{|u| users[2010] << u}
      users_2011.each{|u| users[2011] << u}
      json_users = users.to_json
    else
      users = []
      User.where(year_of_joining: params[:year]).each {|u| users << u}
      json_users = users.to_json
    end

    respond_to do |format|
      format.json do
         render :json => {users: json_users}
      end
    end
  end

end
