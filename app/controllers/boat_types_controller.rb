class BoatTypesController < ApplicationController
  # GET /boat_types
  # GET /boat_types.json
  include ApplicationHelper
  def index
    session[SessionConstants::SELECTED_MENU_ITEM] = 'boat_types'
    @boat_types = BoatType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @boat_types }
    end
  end

  # GET /boat_types/1
  # GET /boat_types/1.json
  def show
    @boat_type = BoatType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @boat_type }
    end
  end

  # GET /boat_types/new
  # GET /boat_types/new.json
  def new
    @boat_type = BoatType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @boat_type }
    end
  end

  # GET /boat_types/1/edit
  def edit
    @boat_type = BoatType.find(params[:id])
  end

  # POST /boat_types
  # POST /boat_types.json
  def create
    @boat_type = BoatType.new(boat_type_params)

    respond_to do |format|
      if @boat_type.save
        format.html { redirect_to "/boat_types", notice: 'Boat type was successfully created.' }
        format.json { render json: @boat_type, status: :created, location: @boat_type }
      else
        format.html { render action: "new" }
        format.json { render json: @boat_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /boat_types/1
  # PUT /boat_types/1.json
  def update
    @boat_type = BoatType.find(params[:id])

    respond_to do |format|
      if @boat_type.update_attributes(boat_type_params)
        format.html { redirect_to "/boat_types", notice: 'Boat type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @boat_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /boat_types/1
  # DELETE /boat_types/1.json
  def destroy
    @boat_type = BoatType.find(params[:id])
    @boat_type.destroy

    respond_to do |format|
      format.html { redirect_to boat_types_url }
      format.json { head :no_content }
    end
  end

  private
  	def boat_type_params
  		params.require(:boat_type).permit(:name,:code,:active)
  	end

end