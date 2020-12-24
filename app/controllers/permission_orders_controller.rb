class PermissionOrdersController < ApplicationController
  # GET /permission_orders
  # GET /permission_orders.json
  def index

    if !current_user.employee
      @permission_orders = PermissionOrder.where(user_id: current_user.id)
    elsif current_user.unit_user || current_user.admin
      @permission_orders = PermissionOrder.where(controll_room_id: current_user.control_room_id)
    else
      @permission_orders = PermissionOrder.all
    end




    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @permission_orders }
    end
  end

  # GET /permission_orders/1
  # GET /permission_orders/1.json
  def show
    @permission_order = PermissionOrder.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @permission_order }
    end
  end

  # GET /permission_orders/new
  # GET /permission_orders/new.json
  def new
    @permission_order = PermissionOrder.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @permission_order }
    end
  end

  # GET /permission_orders/1/edit
  def edit
    @permission_order = PermissionOrder.find(params[:id])
  end

  # POST /permission_orders
  # POST /permission_orders.json
  def create
    @permission_order = PermissionOrder.new(permission_order_params)

    if params[:permission_order][:license_registration_certificate].present?
      uploaded_io = params[:permission_order][:license_registration_certificate]
      file_path_name = UUIDTools::UUID.random_create.to_s.delete '-'
      just_filename = File.basename(uploaded_io.original_filename)
      file_path_name += just_filename.sub(/[^\w\.\-]/, '_')
      File.open(Rails.root.join('public', 'uploads', file_path_name), 'w+b') do |file|
        file.write(uploaded_io.read)
      end
      @permission_order.license_registration_certificate = ApplicationHelper.get_root_url + 'uploads/' + file_path_name
    end
    if params[:permission_order][:routes_permisiion].present?
      uploaded_io = params[:permission_order][:routes_permisiion]
      file_path_name = UUIDTools::UUID.random_create.to_s.delete '-'
      just_filename = File.basename(uploaded_io.original_filename)
      file_path_name += just_filename.sub(/[^\w\.\-]/, '_')
      File.open(Rails.root.join('public', 'uploads', file_path_name), 'w+b') do |file|
        file.write(uploaded_io.read)
      end
      @permission_order.routes_permisiion = ApplicationHelper.get_root_url + 'uploads/' + file_path_name
    end
    if params[:permission_order][:captain_license].present?
      uploaded_io = params[:permission_order][:captain_license]
      file_path_name = UUIDTools::UUID.random_create.to_s.delete '-'
      just_filename = File.basename(uploaded_io.original_filename)
      file_path_name += just_filename.sub(/[^\w\.\-]/, '_')
      File.open(Rails.root.join('public', 'uploads', file_path_name), 'w+b') do |file|
        file.write(uploaded_io.read)
      end
      @permission_order.captain_license = ApplicationHelper.get_root_url + 'uploads/' + file_path_name
    end
    if params[:permission_order][:noc_certificate].present?
      uploaded_io = params[:permission_order][:noc_certificate]
      file_path_name = UUIDTools::UUID.random_create.to_s.delete '-'
      just_filename = File.basename(uploaded_io.original_filename)
      file_path_name += just_filename.sub(/[^\w\.\-]/, '_')
      File.open(Rails.root.join('public', 'uploads', file_path_name), 'w+b') do |file|
        file.write(uploaded_io.read)
      end
      @permission_order.noc_certificate = ApplicationHelper.get_root_url + 'uploads/' + file_path_name
    end

    respond_to do |format|
      if @permission_order.save
        @file_sequence = FileSequence.find_by_file_type("PERMISSION")
        @current_sq_number = @file_sequence.sequence_no.to_i + 1
        @permission_order.update_attributes(:file_no => "PR1920UON" + @current_sq_number.to_s.rjust(6, "0"))
        @permission_order.update_attributes(:controll_room_id => ControlPoint.find_by_name(@permission_order.control_room_location).try(:id))
        @file_sequence.update_attributes(:sequence_no => @current_sq_number)
        @permission_order.save

        format.html { redirect_to @permission_order, notice: 'Permission order was successfully created.' }
        format.json { render json: @permission_order, status: :created, location: @permission_order }
      else
        format.html { render action: "new" }
        format.json { render json: @permission_order.errors, status: :unprocessable_entity }
      end
    end
  end


  def pending_orders
    @permission_orders = PermissionOrder.where("application_status=?","Created")
  end

  def approved_orders
    @permission_orders = PermissionOrder.where("application_status=?","Accepted")
  end

  def rejected_orders
    @permission_orders = PermissionOrder.where("application_status=?","Rjected")
  end


  def accept_orders
    @permission_order = PermissionOrder.find_by_id(params[:id])
    @permission_order.application_status = "Accepted"
    @permission_order.approved_by = current_user.id
    @permission_order.approved_at = Date.today
    @permission_order.save

    redirect_to "/permission_orders/pending_orders"
  end

  def reject_orders
    @permission_order = PermissionOrder.find_by_id(params[:id])
    @permission_order.application_status = "Rjected"
    @permission_order.approved_by = current_user.id
    @permission_order.save
    redirect_to "/permission_orders/pending_orders"
  end



  # PUT /permission_orders/1
  # PUT /permission_orders/1.json
  def update
    @permission_order = PermissionOrder.find(params[:id])

    respond_to do |format|
      if @permission_order.update_attributes(permission_order_params)
        format.html { redirect_to @permission_order, notice: 'Permission order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @permission_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /permission_orders/1
  # DELETE /permission_orders/1.json
  def destroy
    @permission_order = PermissionOrder.find(params[:id])
    @permission_order.destroy

    respond_to do |format|
      format.html { redirect_to permission_orders_url }
      format.json { head :no_content }
    end
  end

    private
    def permission_order_params
      params.require(:permission_order).permit( :control_room_location, :name_of_the_vessel, :registration_number, :owner_of_the_vessel, :owner_email, :mobile_no, :navigation_route, :route_permission_number, :license_registration_certificate, :routes_permisiion, :captain_license, :noc_certificate, :captain_name, :captain_license_no, :application_status, :appllied_date, :approved_by, :approved_at, :approved_document, :user_id, :file_no, :life_jackets, :fire_extinguishers, :passenger_capacity, :life_rafts, :controll_room_id)
    end

end