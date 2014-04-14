class TiresController < ApplicationController
  before_action :set_tire, only: [:show, :edit, :update, :destroy]

  # GET /tires
  # GET /tires.json
  def index
    @tires =  Tire.search(search_params)
  end
  # GET /tires/1
  # GET /tires/1.json
  def show
  end

  # GET /tires/new
  def new
    @tire = Tire.new
  end

  # GET /tires/1/edit
  def edit
  end

  # POST /tires
  # POST /tires.json
  def create
    tire_load = create_params
    
    @tires,@errors = Tire.create_with(tire_load)

    render json: {:created_tires => @tires, :parse_errors => @errors } 
  end

  # PATCH/PUT /tires/1
  # PATCH/PUT /tires/1.json
  def update
    respond_to do |format|
      if @tire.update(tire_params)
        format.html { redirect_to @tire, notice: 'Tire was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @tire.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tires/1
  # DELETE /tires/1.json
  def destroy
    redirect_to :index


    #@tire.destroy
    #respond_to do |format|
 #     format.html { redirect_to tires_url }
  #    format.json { head :no_content }
   # end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tire
      @tire = Tire.find(params[:id])
    end

    def create_params
      params.require(:bulk_load)
    end
    def tire_params
      params.require(:tire).permit(:width_mm, :profile, :rim_inches, :speed_rating)
    end

    def search_params
      params.permit(:gt_height_mm,:lt_height_mm, :lt_height_mm, :rim_inches, :gt_width_mm, :lt_width_mm)
    end

end
