class FiltersController < ApplicationController
  # GET /filters
  # GET /filters.json
  def index
    @filters = Filter.all

    respond_to do |format|
      format.json { render json: @filters }
    end
  end

  # GET /filters/1
  # GET /filters/1.json
  def show
    @filter = Filter.find(params[:id])

    respond_to do |format|
      format.json { render json: @filter }
    end
  end

  # GET /filters/new
  # GET /filters/new.json
  def new
    @filter = Filter.new

    respond_to do |format|
      format.json { render json: @filter }
    end
  end

  # GET /filters/1/edit
  def edit
    @filter = Filter.find(params[:id])
  end

  # POST /filters
  # POST /filters.json
  def create
    @filter = Filter.new(params[:filter])

    respond_to do |format|
      if @filter.save
        format.json { render json: @filter, status: :created, location: @filter }
      else
        format.json { render json: @filter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /filters/1
  # PUT /filters/1.json
  def update
    @filter = Filter.find(params[:id])

    respond_to do |format|
      if @filter.update_attributes(params[:filter])
        format.json { head :no_content }
      else
        format.json { render json: @filter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /filters/1
  # DELETE /filters/1.json
  def destroy
    @filter = Filter.find(params[:id])
    @filter.destroy

    respond_to do |format|
      format.json { head :no_content }
    end
  end
end
