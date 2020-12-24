class NocBoatRegistrationsController < ApplicationController
  # GET /noc_boat_registrations
  # GET /noc_boat_registrations.json
  include ApplicationHelper
  include CcAvenueHelper
  def index
    if !current_user.employee
      @noc_boat_registrations = NocBoatRegistration.where(user_id: current_user.id)
    elsif current_user.unit_user || current_user.admin
      @noc_boat_registrations = NocBoatRegistration.where(controll_room_id: current_user.control_room_id)
    else
      @noc_boat_registrations = NocBoatRegistration.all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json {render json: @noc_boat_registrations}
    end
  end

  # GET /noc_boat_registrations/1
  # GET /noc_boat_registrations/1.json
  def show
    @noc_boat_registration = NocBoatRegistration.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json {render json: @noc_boat_registration}
    end
  end

  # GET /noc_boat_registrations/new
  # GET /noc_boat_registrations/new.json
  def new
    @noc_boat_registration = NocBoatRegistration.new
    @payment = Payment.find_by_tnr_no(params[:tnrId])
    respond_to do |format|
      format.html # new.html.erb
      format.json {render json: @noc_boat_registration}
    end
  end

  # GET /noc_boat_registrations/1/edit
  def edit
    @noc_boat_registration = NocBoatRegistration.find(params[:id])
  end

  # POST /noc_boat_registrations
  # POST /noc_boat_registrations.json
  def create
    @noc_boat_registration = NocBoatRegistration.new(params[:noc_boat_registration])
    if params[:noc_boat_registration][:aadharCard].present?
      uploaded_io = params[:noc_boat_registration][:aadharCard]
      file_path_name = UUIDTools::UUID.random_create.to_s.delete '-'
      just_filename = File.basename(uploaded_io.original_filename)
      file_path_name += just_filename.sub(/[^\w\.\-]/, '_')
      File.open(Rails.root.join('public', 'uploads', file_path_name), 'w+b') do |file|
        file.write(uploaded_io.read)
      end
      @noc_boat_registration.aadharCard = ApplicationHelper.get_root_url + 'uploads/' + file_path_name
    end

    if params[:noc_boat_registration][:manufacturing_certificate].present?
      uploaded_io = params[:noc_boat_registration][:manufacturing_certificate]
      file_path_name = UUIDTools::UUID.random_create.to_s.delete '-'
      just_filename = File.basename(uploaded_io.original_filename)
      file_path_name += just_filename.sub(/[^\w\.\-]/, '_')
      File.open(Rails.root.join('public', 'uploads', file_path_name), 'w+b') do |file|
        file.write(uploaded_io.read)
      end
      @noc_boat_registration.manufacturing_certificate = ApplicationHelper.get_root_url + 'uploads/' + file_path_name
    end

    respond_to do |format|
      if @noc_boat_registration.save


        @file_sequence = FileSequence.find_by_file_type("NOC")
        @current_sq_number = @file_sequence.sequence_no.to_i + 1
        @noc_boat_registration.update_attributes(:file_no => "NOC1920UON" + @current_sq_number.to_s.rjust(6, "0"))
        @noc_boat_registration.update_attributes(:applied_date => Date.today)
        @noc_boat_registration.update_attributes(:controll_room_id => ControlPoint.find_by_name(@noc_boat_registration.proposed_location).try(:id))
        @file_sequence.update_attributes(:sequence_no => @current_sq_number)
        @noc_boat_registration.save

        @payment= Payment.find_by_tnr_no(@noc_boat_registration.tnr_no)
        @payment.update_attributes(:used_file_no => @noc_boat_registration.file_no) if @payment.present?
        @payment.update_attributes(:is_used => true) if @payment.present?

        format.html {redirect_to noc_boat_registrations_url, notice: 'Noc boat registration was successfully created.'}
        format.json {render json: @noc_boat_registration, status: :created, location: @noc_boat_registration}
      else
        format.html {render action: "new"}
        format.json {render json: @noc_boat_registration.errors, status: :unprocessable_entity}
      end
    end
  end

  # PUT /noc_boat_registrations/1
  # PUT /noc_boat_registrations/1.json
  def update
    @noc_boat_registration = NocBoatRegistration.find(params[:id])

    respond_to do |format|
      if @noc_boat_registration.update_attributes(params[:noc_boat_registration])
        format.html {redirect_to @noc_boat_registration, notice: 'Noc boat registration was successfully updated.'}
        format.json {head :no_content}
      else
        format.html {render action: "edit"}
        format.json {render json: @noc_boat_registration.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /noc_boat_registrations/1
  # DELETE /noc_boat_registrations/1.json
  def destroy
    @noc_boat_registration = NocBoatRegistration.find(params[:id])
    @noc_boat_registration.destroy

    respond_to do |format|
      format.html {redirect_to noc_boat_registrations_url}
      format.json {head :no_content}
    end
  end

  def pay_noc_payment

  end

  def checkOut

    @payment = Payment.new
    @payment.mobile_number = params[:mobile_number]
    @payment.amount = params[:amount]
    @payment.email = params[:email]
    @payment.name = params[:name]
    @payment.payment_status = "created"
    @payment.user_id = current_user.id
    @file_sequence = FileSequence.find_by_file_type("PAYMENT")
    @current_sq_number = @file_sequence.sequence_no.to_i + 1
    @payment.tnr_no = "NOC1920PAY" + @current_sq_number.to_s.rjust(6, "0")
    @file_sequence.update_attributes(:sequence_no => @current_sq_number)
    @payment.save

    if @payment.present?
      payment_url = cc_avenue_details(@payment, 'https://testboatingcontrolroom.aptdc.in/noc_boat_registrations/pay_zippy_response')
      redirect_to payment_url
    else
      redirect_to "/noc_boat_registrations"
    end
  end

  def pay_zippy_response

    workingKey = "11CDD88FA9300161D312393FE8CC21E8" #Put in the 32 Bit Working Key provided by CCAVENUES.
    encResponse = params[:encResp]
    decResp = decrypt(encResponse, workingKey);
    decResp = decResp.split("&")
    @ccavenueParams = {}
    decResp.each do |key|
      @ccavenueParams[key.from(0).to(key.index("=") - 1)] = key.from(key.index("=") + 1).to(-1)
    end

    @payment = Payment.find_by_tnr_no(@ccavenueParams["order_id"])
    if @payment.present?
      @payment.payment_status = @ccavenueParams["order_status"]
      @payment.transaction_details = @ccavenueParams
      @payment.save
    end
    if (@payment.present? && @payment.payment_status == 'Success') || (@payment.present? && @payment.payment_status == 'Completed')
      redirect_to "/noc_boat_registrations/new?tnrId=#{@payment.tnr_no}"
    else
      redirect_to "/noc_boat_registrations/pay_noc_payment"
    end
  end


  def pending_noc_boat_registrations
    @noc_boat_registrations = NocBoatRegistration.where("application_status=?","Created")
  end

  def approved_noc_boat_registrations
    @noc_boat_registrations = NocBoatRegistration.where("application_status=?","Accepted")
  end
  def rejected_noc_boat_registrations
    @noc_boat_registrations = NocBoatRegistration.where("application_status=?","Rjected")
  end

  def accept_noc
  @noc_boat_registration = NocBoatRegistration.find_by_id(params[:id])
  @noc_boat_registration.application_status = "Accepted"
  @noc_boat_registration.approved_by = current_user.id
  @noc_boat_registration.approved_date = Date.today
  @noc_boat_registration.save

  redirect_to "/noc_boat_registrations/pending_noc_boat_registrations"
  end

  def reject_noc
    @noc_boat_registration = NocBoatRegistration.find_by_id(params[:id])
    @noc_boat_registration.application_status = "Rjected"
    @noc_boat_registration.approved_by = current_user.id
    @noc_boat_registration.expire_date = Date.today
    @noc_boat_registration.save
    redirect_to "/noc_boat_registrations/pending_noc_boat_registrations"
  end


  def generateNoce
    @noc_boat_registration = NocBoatRegistration.find_by_id(params[:id])

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "Noc#{@noc_boat_registration.id}",
               :margin => {:top                => 5,
                           :bottom             => 5,
                           :left               => 0,
                           :right              => 0},
               :orientation      => 'portrait'
      end
    end
  end

  def noc_registrations
    @noc_boat_registrations = NocBoatRegistration.where("controll_room_id=? and application_status=?", current_user.control_room_id,"Accepted")
  end

  def per_orders
    @permission_orders = PermissionOrder.where("control_room_location=? and application_status=?",ControlPoint.find_by_id(current_user.control_room_id).try(:name),"Accepted")
  end




end