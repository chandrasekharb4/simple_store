class TripDriversController < ApplicationController
  # GET /trip_drivers
  # GET /trip_drivers.json
  def index
    @trip_drivers = TripDriver.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @trip_drivers }
    end
  end

  # GET /trip_drivers/1
  # GET /trip_drivers/1.json
  def show
    @trip_driver = TripDriver.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @trip_driver }
    end
  end

  # GET /trip_drivers/new
  # GET /trip_drivers/new.json
  def new
    @trip_driver = TripDriver.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @trip_driver }
    end
  end

  # GET /trip_drivers/1/edit
  def edit
    @trip_driver = TripDriver.find(params[:id])
  end

  # POST /trip_drivers
  # POST /trip_drivers.json
  def create
    @trip_driver = TripDriver.new(trip_driver_params)

    respond_to do |format|
      if @trip_driver.save
        format.html { redirect_to @trip_driver, notice: 'Trip driver was successfully created.' }
        format.json { render json: @trip_driver, status: :created, location: @trip_driver }
      else
        format.html { render action: "new" }
        format.json { render json: @trip_driver.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /trip_drivers/1
  # PUT /trip_drivers/1.json
  def update
    @trip_driver = TripDriver.find(params[:id])

    respond_to do |format|
      if @trip_driver.update_attributes(trip_driver_params)
        format.html { redirect_to @trip_driver, notice: 'Trip driver was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @trip_driver.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trip_drivers/1
  # DELETE /trip_drivers/1.json
  def destroy
    @trip_driver = TripDriver.find(params[:id])
    @trip_driver.destroy

    respond_to do |format|
      format.html { redirect_to trip_drivers_url }
      format.json { head :no_content }
    end
  end

  	private
  	def trip_driver_params
  		params.require(:trip_driver).permit(:name,:license_number,:boat_id,:trip_id)
  	end

end