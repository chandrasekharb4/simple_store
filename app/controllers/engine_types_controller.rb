class EngineTypesController < ApplicationController
  # GET /engine_types
  # GET /engine_types.json
  include ApplicationHelper
  def index
    session[SessionConstants::SELECTED_MENU_ITEM] = 'engine_types'
    @engine_types = EngineType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @engine_types }
    end
  end

  # GET /engine_types/1
  # GET /engine_types/1.json
  def show
    @engine_type = EngineType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @engine_type }
    end
  end

  # GET /engine_types/new
  # GET /engine_types/new.json
  def new
    @engine_type = EngineType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @engine_type }
    end
  end

  # GET /engine_types/1/edit
  def edit
    @engine_type = EngineType.find(params[:id])
  end

  # POST /engine_types
  # POST /engine_types.json
  def create
    @engine_type = EngineType.new(engine_type_params)

    respond_to do |format|
      if @engine_type.save
        format.html { redirect_to "/engine_types", notice: 'Engine type was successfully created.' }
        format.json { render json: @engine_type, status: :created, location: @engine_type }
      else
        format.html { render action: "new" }
        format.json { render json: @engine_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /engine_types/1
  # PUT /engine_types/1.json
  def update
    @engine_type = EngineType.find(params[:id])

    respond_to do |format|
      if @engine_type.update_attributes(engine_type_params)
        format.html { redirect_to "/engine_types", notice: 'Engine type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @engine_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /engine_types/1
  # DELETE /engine_types/1.json
  def destroy
    @engine_type = EngineType.find(params[:id])
    @engine_type.destroy

    respond_to do |format|
      format.html { redirect_to engine_types_url }
      format.json { head :no_content }
    end
  end
  	private
  	def engine_type_params
  		params.require(:engine_type).permit(:name,:code,:active)
  	end
end