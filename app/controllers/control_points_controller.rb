class ControlPointsController < ApplicationController
  # GET /control_points
  # GET /control_points.json
  
  include ApplicationHelper
  def index
    session[SessionConstants::SELECTED_MENU_ITEM] = 'control_points'
    @control_points = ControlPoint.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @control_points }
    end
  end

  # GET /control_points/1
  # GET /control_points/1.json
  def show
    @control_point = ControlPoint.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @control_point }
    end
  end

  # GET /control_points/new
  # GET /control_points/new.json
  def new
    @control_point = ControlPoint.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @control_point }
    end
  end

  # GET /control_points/1/edit
  def edit
    @control_point = ControlPoint.find(params[:id])
  end

  # POST /control_points
  # POST /control_points.json
  def create
    @control_point = ControlPoint.new(control_point_params)
    if params[:control_point][:image].present?
      uploaded_io = params[:control_point][:image]
      file_path_name = UUIDTools::UUID.random_create.to_s.delete '-'
      just_filename = File.basename(uploaded_io.original_filename)
      file_path_name += just_filename.sub(/[^\w\.\-]/, '_')
      File.open(Rails.root.join('public', 'uploads1', file_path_name), 'w+b') do |file|
        file.write(uploaded_io.read)
      end
      @control_point.image = ApplicationHelper.get_root_url + 'uploads1/' + file_path_name
    end
    respond_to do |format|
      if @control_point.save
        format.html { redirect_to "/control_points", notice: 'Control point was successfully created.' }
        format.json { render json: @control_point, status: :created, location: @control_point }
      else
        format.html { render action: "new" }
        format.json { render json: @control_point.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /control_points/1
  # PUT /control_points/1.json
  def update
    @control_point = ControlPoint.find(params[:id])

    if params[:control_point][:image].present?
      uploaded_io = params[:control_point][:image]
      file_path_name = UUIDTools::UUID.random_create.to_s.delete '-'
      just_filename = File.basename(uploaded_io.original_filename)
      file_path_name += just_filename.sub(/[^\w\.\-]/, '_')
      File.open(Rails.root.join('public', 'uploads1', file_path_name), 'w+b') do |file|
        file.write(uploaded_io.read)
      end
      params[:control_point][:image] = ApplicationHelper.get_root_url + 'uploads1/' + file_path_name
    end





    respond_to do |format|
      if @control_point.update_attributes(control_point_params)
        format.html { redirect_to "/control_points", notice: 'Control point was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @control_point.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /control_points/1
  # DELETE /control_points/1.json
  def destroy
    @control_point = ControlPoint.find(params[:id])
    @control_point.destroy

    respond_to do |format|
      format.html { redirect_to control_points_url }
      format.json { head :no_content }
    end
  end
  private
  def control_point_params
	params.require(:control_point).permit(:name, :location, :district, :contact_number, :email, :active, :code, :image)

end
end