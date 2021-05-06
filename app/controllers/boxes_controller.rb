class BoxesController < ApplicationController
  before_action :set_box, only: %i[ show destroy ]

  # GET /boxes or /boxes.json
  def index
    @boxes = Box.all
  end

  # GET /boxes/1 or /boxes/1.json
  def show
    @items = @box.items.order(:created_at)
  end

  # GET /boxes/new
  def new
    @box = Box.new
  end

  # POST /boxes or /boxes.json
  def create
    @box = current_user.boxes.build(box_params.merge(member: current_member))
    respond_to do |format|
      if @box.save
        qrcode = RQRCode::QRCode.new("#{request.url}/#{@box.id}")
        svg = qrcode.as_svg(
          offset: 0,
          color: '000',
          shape_rendering: 'crispEdges',
          module_size: 4,
          standalone: true
        )
        @box.update(qr_code: svg)
        format.html { redirect_to @box, notice: "Box was successfully created." }
        format.json { render :show, status: :created, location: @box }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @box.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /boxes/1 or /boxes/1.json
  def destroy
    @box.destroy
    respond_to do |format|
      format.html { redirect_to boxes_url, notice: "Box was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_box
      @box = Box.find(params[:id])
    rescue
      redirect_to accounts_path, alert: "Choose the proper account"
    end

    # Only allow a list of trusted parameters through.
    def box_params
      params.require(:box).permit(:name, items_attributes: [:description, :image, :_destroy])
    end
end
