class FileSequencesController < ApplicationController
  # GET /file_sequences
  # GET /file_sequences.json
  def index
    @file_sequences = FileSequence.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @file_sequences }
    end
  end

  # GET /file_sequences/1
  # GET /file_sequences/1.json
  def show
    @file_sequence = FileSequence.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @file_sequence }
    end
  end

  # GET /file_sequences/new
  # GET /file_sequences/new.json
  def new
    @file_sequence = FileSequence.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @file_sequence }
    end
  end

  # GET /file_sequences/1/edit
  def edit
    @file_sequence = FileSequence.find(params[:id])
  end

  # POST /file_sequences
  # POST /file_sequences.json
  def create
    @file_sequence = FileSequence.new(file_sequence_params)

    respond_to do |format|
      if @file_sequence.save
        format.html { redirect_to "/file_sequences", notice: 'File sequence was successfully created.' }
        format.json { render json: @file_sequence, status: :created, location: @file_sequence }
      else
        format.html { render action: "new" }
        format.json { render json: @file_sequence.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /file_sequences/1
  # PUT /file_sequences/1.json
  def update
    @file_sequence = FileSequence.find(params[:id])

    respond_to do |format|
      if @file_sequence.update_attributes(file_sequence_params)
        format.html { redirect_to "/file_sequences", notice: 'File sequence was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @file_sequence.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /file_sequences/1
  # DELETE /file_sequences/1.json
  def destroy
    @file_sequence = FileSequence.find(params[:id])
    @file_sequence.destroy

    respond_to do |format|
      format.html { redirect_to file_sequences_url }
      format.json { head :no_content }
    end
  end
  	private
  	def file_sequence_params
  		params.require(:file_sequence).permit(:file_type,:sequence_no)
  	end
end