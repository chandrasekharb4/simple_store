class UserSessionsController < ApplicationController
  include ApplicationHelper

  def new
    @user_session = UserSession.new
    respond_to do |format|
      format.html {render :layout => false}
    end
  end

  def create
    user = User.find_by_employee_code(params[:user_session][:email])
    ##user = User.find_by_email(params[:user_session][:email])
    params[:user_session][:email] = user.email if user.present?
    @user_session = UserSession.new(permitted_params)
    if @user_session.save
      if !current_user.employee
        redirect_to "/users/user_dashBoard"
      else
        if current_user.super_admin
          redirect_to "/users/ho_dashBoard1"
        elsif  current_user.unit_user
          redirect_to "/users/unit_dashboard"
        elsif  current_user.ho_user
          redirect_to "/users/ho_dashBoard1"
        else
          redirect_to "/noc_boat_registrations/pending_noc_boat_registrations"
        end
      end
    else
      render :action => 'new', :layout => false
    end
  end

  def destroy
    @user_session = UserSession.find
    if @user_session.present?
      @user_session.destroy
      reset_session
    end
    redirect_to root_url
  end

  def permitted_params
    if Rails.version < '5'
      params.require(:user_session).permit(:email, :password)
    else
      params.require(:user_session).permit(:email, :password).to_hash
    end
  end

end