class BoxesController < ApplicationController
  include CableReady::Broadcaster
  before_action :set_box, only: %i[ show destroy ]

  # GET /boxes or /boxes.json
  def index
    @boxes = Box.order(:created_at)
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
    @box = current_tenant.boxes.build(box_params)
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
      cable_ready["accounts_channel:#{current_tenant.id}"].insert_adjacent_html(
        selector: "#boxes",
        position: "beforeend",
        html: render_to_string(partial: "box", locals: { box: @box })
      )
      cable_ready.broadcast
      redirect_to boxes_path, notice: "Box was successfully created."
    end
  end

  # DELETE /boxes/1 or /boxes/1.json
  def destroy
    @box.destroy
    cable_ready["accounts_channel:#{current_tenant.id}"].remove(
      selector: "#box-#{@box.id}"
    )
    cable_ready.broadcast
    redirect_to boxes_url, notice: "Box was successfully destroyed."
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
