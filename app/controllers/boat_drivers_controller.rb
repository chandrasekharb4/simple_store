class BoatDriversController < ApplicationController
  # GET /boat_drivers
  # GET /boat_drivers.json
  def index
    @boat_drivers = BoatDriver.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @boat_drivers }
    end
  end

  # GET /boat_drivers/1
  # GET /boat_drivers/1.json
  def show
    @boat_driver = BoatDriver.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @boat_driver }
    end
  end

  # GET /boat_drivers/new
  # GET /boat_drivers/new.json
  def new
    @boat_driver = BoatDriver.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @boat_driver }
    end
  end

  # GET /boat_drivers/1/edit
  def edit
    @boat_driver = BoatDriver.find(params[:id])
  end

  # POST /boat_drivers
  # POST /boat_drivers.json
  def create
    @boat_driver = BoatDriver.new(boat_driver_params)

    respond_to do |format|
      if @boat_driver.save
        format.html { redirect_to @boat_driver, notice: 'Boat driver was successfully created.' }
        format.json { render json: @boat_driver, status: :created, location: @boat_driver }
      else
        format.html { render action: "new" }
        format.json { render json: @boat_driver.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /boat_drivers/1
  # PUT /boat_drivers/1.json
  def update
    @boat_driver = BoatDriver.find(params[:id])

    respond_to do |format|
      if @boat_driver.update_attributes(boat_driver_params)
        format.html { redirect_to @boat_driver, notice: 'Boat driver was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @boat_driver.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /boat_drivers/1
  # DELETE /boat_drivers/1.json
  def destroy
    @boat_driver = BoatDriver.find(params[:id])
    @boat_driver.destroy

    respond_to do |format|
      format.html { redirect_to boat_drivers_url }
      format.json { head :no_content }
    end
  end

  private
  def boat_driver_params
  	params.require(:boat_driver).permit(:boat_id,:name,:license_numner)	
  end

end