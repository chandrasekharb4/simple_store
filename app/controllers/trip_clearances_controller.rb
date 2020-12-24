class TripClearancesController < ApplicationController
  # GET /trip_clearances
  # GET /trip_clearances.json
  def index

    if !current_user.employee
      @boats = Boat.where(user_id: current_user.id)
    elsif current_user.unit_user || current_user.admin
      @boats = Boat.where(control_room_id: current_user.control_room_id)
    else
      @boats = Boat.all
    end

    @trip_clearances = []
    @selectedDate = params[:departure_date].present? ? params[:departure_date] : Date.today
    @boats.each do |boat|
      @trip_clearances += TripClearance.where("boat_id=?",boat.id).date_scope(@selectedDate)
    end



    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @trip_clearances }
      format.js
    end
  end

  # GET /trip_clearances/1
  # GET /trip_clearances/1.json
  def show
    @trip_clearance = TripClearance.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @trip_clearance }
    end
  end

  # GET /trip_clearances/new
  # GET /trip_clearances/new.json
  def new
    @trip_clearance = TripClearance.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @trip_clearance }
    end
  end

  # GET /trip_clearances/1/edit
  def edit
    @trip_clearance = TripClearance.find(params[:id])
  end

  # POST /trip_clearances
  # POST /trip_clearances.json
  def create
    @trip_clearance = TripClearance.new(trip_params)

    respond_to do |format|
      if @trip_clearance.save
        format.html { redirect_to @trip_clearance, notice: 'Trip clearance was successfully created.' }
        format.json { render json: @trip_clearance, status: :created, location: @trip_clearance }
      else
        format.html { render action: "new" }
        format.json { render json: @trip_clearance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /trip_clearances/1
  # PUT /trip_clearances/1.json
  def update
    @trip_clearance = TripClearance.find(params[:id])

    respond_to do |format|
      if @trip_clearance.update_attributes(trip_params)
        format.html { redirect_to @trip_clearance, notice: 'Trip clearance was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @trip_clearance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trip_clearances/1
  # DELETE /trip_clearances/1.json
  def destroy
    @trip_clearance = TripClearance.find(params[:id])
    @trip_clearance.destroy

    respond_to do |format|
      format.html { redirect_to trip_clearances_url }
      format.json { head :no_content }
    end
  end

  private
  def trip_params
  	params.require(:trip_clearance).permit(:boat_id, :control_room_id, :name_of_the_vessel, :registration_number, :owner_of_the_vessel, :owner_email, :mobile_no, :navigation_route, :route_permission_number, :captain_name, :captain_license_no, :created_by, :life_jackets, :fire_extinguishers, :passenger_capacity, :life_rafts, :life_buoys, :trip_duriation, :boat_type, :engine_type, :proposed_use, :is_current, :departure_date, :wearing_life_jackets, :influence_of_alcohol, :trip_end, :trip_no, :start_time, :end_time, :remarks, :passenger_count, :briefed_to_passenger, :overloaded, :wearing_life_jackets_all, :influence_of_alcohol_all, :registered_with_aptdc, :has_route_permissions, :has_prominently_displays_the_capacity, :has_lifesaving_equipment, :has_adequate_firefighting_equipment, :does_not_have_any_major_damage, :has_crew_displayed, :driver_has_the_requisite_license_and_is_registered, :crew_have_the_requisite_licenses_and_are_registered, :boat_driver_and_the_crew_have_their_identity_cards_badges, :crew_is_fit_and_healthy_not)
  end

end