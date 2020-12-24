class BoatsController < ApplicationController
  # GET /boats
  # GET /boats.json
  def index

    if !current_user.employee
      @boats = Boat.where(user_id: current_user.id)
    elsif current_user.unit_user || current_user.admin
      @boats = Boat.where(control_room_id: current_user.control_room_id)
    else
      @boats = Boat.all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json {render json: @boats}
    end
  end

  # GET /boats/1
  # GET /boats/1.json
  def show
    @boat = Boat.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json {render json: @boat}
    end
  end

  # GET /boats/new
  # GET /boats/new.json
  def new
    @boat = Boat.new

    respond_to do |format|
      format.html # new.html.erb
      format.json {render json: @boat}
    end
  end

  # GET /boats/1/edit
  def edit
    @boat = Boat.find(params[:id])
  end

  # POST /boats
  # POST /boats.json
  def create
    @boat = Boat.new(boat_params)

    respond_to do |format|
      if @boat.save
=begin
        @user = User.find_by_mobile_no(@boat.mobile_no)
        @boat.user_id = @user.id if @user.present?
        @boat.save
=end
        format.html {redirect_to @boat, notice: 'Boat was successfully created.'}
        format.json {render json: @boat, status: :created, location: @boat}
      else
        format.html {render action: "new"}
        format.json {render json: @boat.errors, status: :unprocessable_entity}
      end
    end
  end

  # PUT /boats/1
  # PUT /boats/1.json
  def update
    @boat = Boat.find(params[:id])

    respond_to do |format|
      if @boat.update_attributes(boat_params)
=begin
        @user = User.find_by_mobile_no(@boat.mobile_no)
        @boat.user_id = @user.id if @user.present?
        @boat.save
=end
        format.html {redirect_to @boat, notice: 'Boat was successfully updated.'}
        format.json {head :no_content}
      else
        format.html {render action: "edit"}
        format.json {render json: @boat.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /boats/1
  # DELETE /boats/1.json
  def destroy
    @boat = Boat.find(params[:id])
    @boat.destroy

    respond_to do |format|
      format.html {redirect_to boats_url}
      format.json {head :no_content}
    end
  end


  def boatActive
    @boat = Boat.find_by_id(params[:id])
    @boat.status = "Accepted"
    @boat.save

    redirect_to "/boats/#{@boat.id}"
  end

  def boatInActive
    @boat = Boat.find_by_id(params[:id])
    @boat.status = "Rejected"
    @boat.save
    redirect_to "/boats/#{@boat.id}"
  end

  def boatClearance
    @boat = Boat.find_by_id(params[:id])
  end

  def updateBoatClearance
    @trip = TripClearance.new
    @trip.boat_id = params[:boat_id] if params[:boat_id].present?
    @trip.control_room_id = params[:control_room_id] if params[:control_room_id].present?
    @trip.name_of_the_vessel = params[:name_of_the_vessel] if params[:name_of_the_vessel].present?
    @trip.registration_number = params[:registration_number] if params[:registration_number].present?
    @trip.owner_of_the_vessel = params[:owner_of_the_vessel] if params[:owner_of_the_vessel].present?
    @trip.owner_email = params[:owner_email] if params[:owner_email].present?
    @trip.mobile_no = params[:mobile_no] if params[:mobile_no].present?
    @trip.navigation_route = params[:navigation_route] if params[:navigation_route].present?
    @trip.route_permission_number = params[:route_permission_number] if params[:route_permission_number].present?
    @trip.captain_name = params[:captain_name] if params[:captain_name].present?
    @trip.captain_license_no = params[:captain_license_no] if params[:captain_license_no].present?
    @trip.life_jackets = params[:life_jackets] if params[:life_jackets].present?
    @trip.fire_extinguishers = params[:fire_extinguishers] if params[:fire_extinguishers].present?
    @trip.passenger_capacity = params[:passenger_capacity] if params[:passenger_capacity].present?
    @trip.life_rafts = params[:life_rafts] if params[:life_rafts].present?
    @trip.life_buoys = params[:life_buoys] if params[:life_buoys].present?
    @trip.trip_duriation = params[:trip_duriation] if params[:trip_duriation].present?
    @trip.boat_type = params[:boat_type] if params[:boat_type].present?
    @trip.engine_type = params[:engine_type] if params[:engine_type].present?
    @trip.proposed_use = params[:proposed_use] if params[:proposed_use].present?
    @trip.departure_date = params[:departure_date] if params[:departure_date].present?
    @trip.wearing_life_jackets = params[:wearing_life_jackets].present? && params[:wearing_life_jackets].eql?("YES") ? true : false
    @trip.influence_of_alcohol = params[:influence_of_alcohol].present? && params[:influence_of_alcohol].eql?("YES") ? true : false
    @trip.passenger_count = params[:passenger_count] if params[:passenger_count].present?
    @trip.briefed_to_passenger = params[:briefed_to_passenger] if params[:briefed_to_passenger].present?
    @trip.overloaded = params[:overloaded] if params[:overloaded].present?
    @trip.influence_of_alcohol_all = params[:influence_of_alcohol_all] if params[:influence_of_alcohol_all].present?
    @trip.registered_with_aptdc = params[:registered_with_aptdc] if params[:registered_with_aptdc].present?
    @trip.has_route_permissions = params[:has_route_permissions] if params[:has_route_permissions].present?
    @trip.has_prominently_displays_the_capacity = params[:has_prominently_displays_the_capacity] if params[:has_prominently_displays_the_capacity].present?
    @trip.has_lifesaving_equipment = params[:has_lifesaving_equipment] if params[:has_lifesaving_equipment].present?
    @trip.has_adequate_firefighting_equipment = params[:has_adequate_firefighting_equipment] if params[:has_adequate_firefighting_equipment].present?
    @trip.does_not_have_any_major_damage = params[:does_not_have_any_major_damage] if params[:does_not_have_any_major_damage].present?
    @trip.has_crew_displayed = params[:has_crew_displayed] if params[:has_crew_displayed].present?
    @trip.driver_has_the_requisite_license_and_is_registered = params[:driver_has_the_requisite_license_and_is_registered] if params[:driver_has_the_requisite_license_and_is_registered].present?
    @trip.crew_have_the_requisite_licenses_and_are_registered = params[:crew_have_the_requisite_licenses_and_are_registered] if params[:crew_have_the_requisite_licenses_and_are_registered].present?
    @trip.boat_driver_and_the_crew_have_their_identity_cards_badges = params[:boat_driver_and_the_crew_have_their_identity_cards_badges] if params[:boat_driver_and_the_crew_have_their_identity_cards_badges].present?
    @trip.crew_is_fit_and_healthy_not = params[:crew_is_fit_and_healthy_not] if params[:crew_is_fit_and_healthy_not].present?
    @trip.wearing_life_jackets_all = params[:wearing_life_jackets_all] if params[:wearing_life_jackets_all]
    @trip.start_time = Time.now
    @trip.trip_end = false
    @trip.is_current = true
    @file_sequence = FileSequence.find_by_file_type("NOC")
    @current_sq_number = @file_sequence.sequence_no.to_i + 1
    @file_sequence.update_attributes(:sequence_no => @current_sq_number)
    @trip.trip_no = "TRIP1920" + @current_sq_number.to_s.rjust(6, "0")
    @trip.created_by = current_user.id
    @trip.save
    @boat = Boat.find_by_id(@trip.boat_id)
    @boat.trip_run = true
    @boat.save

    params.keys.each do |key|
      if key.starts_with?('crewName_')
        split_keys = key.split('_')
        index = key.split('_')[1]
        @trip_driver = TripDriver.new
        @trip_driver.name = params["crewName_#{index}"]
        @trip_driver.license_number = params["crewLicense_#{index}"]
        @trip_driver.boat_id = @boat.id
        @trip_driver.trip_id = @trip.id
        @trip_driver.save
      end
    end

    redirect_to "/boats/display_trip_details?boat_id=#{@trip.boat_id}"
  end

  def display_trip_details
    if params[:boat_id].present?
      @boat = Boat.find_by_id(params[:boat_id])
      @trip_clearance = TripClearance.find_by_boat_id_and_is_current(@boat.id,true)
      @trip_drivers = TripDriver.where("trip_id=? and boat_id=?",@trip_clearance.id,@boat.id)
    end
  end

  def display_trip_details1
    if params[:boat_id].present? && params[:trip_id].present?
      @boat = Boat.find_by_id(params[:boat_id])
      @trip_clearance = TripClearance.find_by_boat_id_and_id(@boat.id,params[:trip_id])
      @trip_drivers = TripDriver.where("trip_id=? and boat_id=?",@trip_clearance.id,@boat.id)
    end
  end

  def generateclearance
    if params[:boat_id].present? && params[:trip_id].present?
      @boat = Boat.find_by_id(params[:boat_id])
      @trip_clearance = TripClearance.find_by_boat_id_and_id(@boat.id,params[:trip_id])
      @trip_drivers = TripDriver.where("trip_id=? and boat_id=?",@trip_clearance.id,@boat.id)
    end
  end


  def trip_end
    if params[:boat_id].present?
      @boat = Boat.find_by_id(params[:boat_id])
      @trip_clearance = TripClearance.find_by_boat_id_and_is_current(@boat.id, true)
      @trip_clearance.update_attributes(:is_current => false)
      @trip_clearance.update_attributes(:trip_end => true)
      @trip_clearance.update_attributes(:end_time => Time.now)
      @boat.update_attributes(:trip_run => false)
    end
    redirect_to "/boats"
  end

  private
  	def boat_params
  		params.require(:boat).permit( :name, :control_room_id, :name_of_the_vessel, :registration_number, :owner_of_the_vessel, :owner_email, :mobile_no, :navigation_route, :route_permission_number, :captain_name, :captain_license_no, :created_by, :user_id, :life_jackets, :fire_extinguishers, :passenger_capacity, :life_rafts, :life_buoys, :trip_duriation, :boat_type, :engine_type, :proposed_use, :active, :permission_file_no, :status, :trip_run, :division_id, :unit_id)
  	end

end