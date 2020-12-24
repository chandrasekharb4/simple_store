class ProposedUsesController < ApplicationController
  # GET /proposed_uses
  # GET /proposed_uses.json
  include ApplicationHelper
  def index
    session[SessionConstants::SELECTED_MENU_ITEM] = 'proposed_uses'
    @proposed_uses = ProposedUse.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @proposed_uses }
    end
  end

  # GET /proposed_uses/1
  # GET /proposed_uses/1.json
  def show
    @proposed_use = ProposedUse.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @proposed_use }
    end
  end

  # GET /proposed_uses/new
  # GET /proposed_uses/new.json
  def new
    @proposed_use = ProposedUse.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @proposed_use }
    end
  end

  # GET /proposed_uses/1/edit
  def edit
    @proposed_use = ProposedUse.find(params[:id])
  end

  # POST /proposed_uses
  # POST /proposed_uses.json
  def create
    @proposed_use = ProposedUse.new(proposed_use_params)

    respond_to do |format|
      if @proposed_use.save
        format.html { redirect_to "/proposed_uses", notice: 'Proposed use was successfully created.' }
        format.json { render json: @proposed_use, status: :created, location: @proposed_use }
      else
        format.html { render action: "new" }
        format.json { render json: @proposed_use.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /proposed_uses/1
  # PUT /proposed_uses/1.json
  def update
    @proposed_use = ProposedUse.find(params[:id])

    respond_to do |format|
      if @proposed_use.update_attributes(proposed_use_params)
        format.html { redirect_to "/proposed_uses", notice: 'Proposed use was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @proposed_use.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /proposed_uses/1
  # DELETE /proposed_uses/1.json
  def destroy
    @proposed_use = ProposedUse.find(params[:id])
    @proposed_use.destroy

    respond_to do |format|
      format.html { redirect_to proposed_uses_url }
      format.json { head :no_content }
    end
  end
  	private
  	def proposed_use_params
  		params.require(:proposed_use).permit(:name,:code,:active)
  	end
end