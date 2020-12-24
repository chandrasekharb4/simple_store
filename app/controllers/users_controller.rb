class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  include ApplicationHelper
  def index
    session[SessionConstants::SELECTED_MENU_ITEM] = 'users'
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html {render :layout => false}
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to "/users/user_dashBoard", notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(user_params)
        format.html { redirect_to "/users", notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  def homePage

    render :layout => false
  end
  def contactUs

    render :layout => false
  end

  def employee_list
     @users = User.where(control_room_id: current_user.control_room_id)
  end

  def create_employee
    @user = User.find_by_id(params[:user_id]) if params[:user_id].present?
  end

  def update_employee
    @user = User.find_by_id(params[:user_id]) if params[:user_id].present?
    @user = User.new if @user.blank?
    @user.name = params[:name]
    @user.mobile_no = params[:mobile_no]
    @user.control_room_id = params[:control_room_id]
    @user.email = params[:email]
    @user.user_role = params[:user_role]
    @user.employee = true
    @user.unit_user = true
    @user.password = "CROE1234"
    @user.password_confirmation = "CROE1234"
    @user.save
    redirect_to '/users/employee_list'
  end


  def create_admin

  end

  def update_admin
    @user = User.new
    @user.name = params[:name]
    @user.mobile_no = params[:mobile_no]
    @user.control_room_id = params[:control_room_id]
    @user.email = params[:email]
    @user.admin = true
    @user.employee = true
    @user.unit_user = true
    @user.password = "CRO12345"
    @user.password_confirmation = "CRO12345"
    @user.save
    redirect_to '/users'
  end


  def unit_dashboard
    @dashboard_data ={}
    @dashboard_data['AppliedNoc'] = NocBoatRegistration.where("controll_room_id=?",current_user.control_room_id).size()
    @dashboard_data['ApprovedNoc'] = NocBoatRegistration.where("controll_room_id=? and application_status=?",current_user.control_room_id,"Accepted").size()
    @dashboard_data['RejectedNoc'] = NocBoatRegistration.where("controll_room_id=? and application_status=?",current_user.control_room_id,"Rjected").size()
    @dashboard_data['PendingNoc'] = NocBoatRegistration.where("controll_room_id=? and application_status=?",current_user.control_room_id,"Created").size()
    @dashboard_data['AppliedPer'] = PermissionOrder.where("controll_room_id=?",current_user.control_room_id).size()
    @dashboard_data['ApprovedPer'] = PermissionOrder.where("controll_room_id=? and application_status=?",current_user.control_room_id,"Accepted").size()
    @dashboard_data['RejectedPer'] = PermissionOrder.where("controll_room_id=? and application_status=?",current_user.control_room_id,"Rjected").size()
    @dashboard_data['PendingPer'] = PermissionOrder.where("controll_room_id=? and application_status=?",current_user.control_room_id,"Created").size()

    @dashboard_data['AppliedBoats'] = Boat.where("control_room_id=?",current_user.control_room_id).size()
    @dashboard_data['ActiveBoats'] = Boat.where("control_room_id=? and status=?",current_user.control_room_id,"Accepted").size()
    @dashboard_data['InactiveBoats'] = Boat.where("control_room_id=? and status=?",current_user.control_room_id,"Rejected").size()
    @dashboard_data['RunningBoats'] = Boat.where("control_room_id=? and trip_run=?",current_user.control_room_id,true).size()

    @running_trips = []
    @running_boats = Boat.where("control_room_id=? and trip_run=?",current_user.control_room_id,true)
    @running_boats.each do |boat|
      @running_trips << TripClearance.find_by_boat_id_and_is_current(boat.id,true)
    end
  end

  def user_dashBoard
    @dashboard_data ={}
    @dashboard_data['AppliedNoc'] = NocBoatRegistration.where("user_id=?",current_user.id).size()
    @dashboard_data['ApprovedNoc'] = NocBoatRegistration.where("user_id=? and application_status=?",current_user.id,"Accepted").size()
    @dashboard_data['RejectedNoc'] = NocBoatRegistration.where("user_id=? and application_status=?",current_user.id,"Rjected").size()
    @dashboard_data['PendingNoc'] = NocBoatRegistration.where("user_id=? and application_status=?",current_user.id,"Created").size()
    @dashboard_data['AppliedPer'] = PermissionOrder.where("user_id=?",current_user.id).size()
    @dashboard_data['ApprovedPer'] = PermissionOrder.where("user_id=? and application_status=?",current_user.id,"Accepted").size()
    @dashboard_data['RejectedPer'] = PermissionOrder.where("user_id=? and application_status=?",current_user.id,"Rjected").size()
    @dashboard_data['PendingPer'] = PermissionOrder.where("user_id=? and application_status=?",current_user.id,"Created").size()

    @dashboard_data['AppliedBoats'] = Boat.where("user_id=?",current_user.id).size()
    @dashboard_data['ActiveBoats'] = Boat.where("user_id=? and status=?",current_user.id,"Accepted").size()
    @dashboard_data['InactiveBoats'] = Boat.where("user_id=? and status=?",current_user.id,"Rejected").size()
    @dashboard_data['RunningBoats'] = Boat.where("user_id=? and trip_run=?",current_user.id,true).size()

    @running_trips = []
    @running_boats = Boat.where("user_id=? and trip_run=?",current_user.id,true)
    @running_boats.each do |boat|
      @running_trips << TripClearance.find_by_boat_id_and_is_current(boat.id,true)
    end

  end


  def ho_dashBoard

    @dashboard_data ={}
    @dashboard_data['AppliedNoc'] = NocBoatRegistration.all.size()
    @dashboard_data['ApprovedNoc'] = NocBoatRegistration.where("application_status=?","Accepted").size()
    @dashboard_data['RejectedNoc'] = NocBoatRegistration.where("application_status=?","Rjected").size()
    @dashboard_data['PendingNoc'] = NocBoatRegistration.where("application_status=?","Created").size()
    @dashboard_data['AppliedPer'] = PermissionOrder.all.size()
    @dashboard_data['ApprovedPer'] = PermissionOrder.where("application_status=?","Accepted").size()
    @dashboard_data['RejectedPer'] = PermissionOrder.where("application_status=?","Rjected").size()
    @dashboard_data['PendingPer'] = PermissionOrder.where("application_status=?","Created").size()

    @dashboard_data['AppliedBoats'] = Boat.all.size()
    @dashboard_data['ActiveBoats'] = Boat.where("status=?","Accepted").size()
    @dashboard_data['InactiveBoats'] = Boat.where("status=?","Rejected").size()
    @dashboard_data['RunningBoats'] = Boat.where("trip_run=?",true).size()

    @running_trips = []
    @running_boats = Boat.where("trip_run=?",true)
    @running_boats.each do |boat|
      @running_trips << TripClearance.find_by_boat_id_and_is_current(boat.id,true)
    end

  end

  def ho_dashBoard1

    @dashboard_data ={}
    @camp_data ={}
    @dashboard_data['AppliedNoc'] = NocBoatRegistration.all.size()
    @dashboard_data['ApprovedNoc'] = NocBoatRegistration.where("application_status=?","Accepted").size()
    @dashboard_data['PendingNoc'] = NocBoatRegistration.where("application_status=?","Created").size()
    @dashboard_data['AppliedPer'] = PermissionOrder.all.size()
    @dashboard_data['ApprovedPer'] = PermissionOrder.where("application_status=?","Accepted").size()
    @dashboard_data['PendingPer'] = PermissionOrder.where("application_status=?","Created").size()
    @dashboard_data['AppliedBoats'] = Boat.all.size()
    @dashboard_data['ActiveBoats'] = Boat.where("status=?","Accepted").size()
    @dashboard_data['RunningBoats'] = Boat.where("trip_run=?",true).size()

    @controllPoints = ControlPoint.all
    @controllPoints.each do |controll_point|
      @camp_data[controll_point.id] = {}
      @camp_data[controll_point.id]['Name'] = controll_point.name
      @camp_data[controll_point.id]['DisName'] = controll_point.district
      @camp_data[controll_point.id]['RunningVissels'] = Boat.where("control_room_id=? and trip_run=?",controll_point.id,true).size()
      @camp_data[controll_point.id]['ApprovedNoc'] = NocBoatRegistration.where("controll_room_id=? and application_status=?",controll_point.id,"Accepted").size()
      @camp_data[controll_point.id]['PendingNoc'] = NocBoatRegistration.where("controll_room_id=? and application_status=?",controll_point.id,"Created").size()
      @camp_data[controll_point.id]['ApprovedPer'] = PermissionOrder.where("controll_room_id=? and application_status=?",controll_point.id,"Accepted").size()
      @camp_data[controll_point.id]['PendingPer'] = PermissionOrder.where("controll_room_id=? and application_status=?",controll_point.id,"Created").size()
    end


    @running_trips = []
    @running_boats = Boat.where("trip_run=?",true)
    @running_boats.each do |boat|
      @running_trips << TripClearance.find_by_boat_id_and_is_current(boat.id,true)
    end


  end

  private
  	def user_params
  		params.require(:user).permit(:control_room_id, :crypted_password, :email, :employee, :employee_code, :mobile_no, :name, :password, :password_confirmation, :password_salt, :perishable_token, :persistence_token, :super_admin, :user_role,:ho_user, :unit_user,:admin)
  	end



end