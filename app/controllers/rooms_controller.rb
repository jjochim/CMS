class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update, :destroy]
  # GET /rooms
  # GET /rooms.json
  def index
    @rooms = Room.paginate(:page => params[:page])
  end

  # GET /rooms/1
  # GET /rooms/1.json
  def show
    @seatings = Seating.where(room_id: @room.id)

    @responseObject = Array[]

    (0..@room.rows-1).each do
      @responseObject.push(Array[])
    end

    (0..@room.rows-1).each do |i|
      (0..@room.columns-1).each do |j|
        if ((i)*@room.columns + (j+1) <= @room.columns * @room.rows)
          @responseObject[i].push(@seatings[((i)*@room.columns + (j+1)-1)])
        end
      end
    end
  end

  # GET /rooms/new
  def new
    @room = Room.new
  end

  # GET /rooms/1/edit
  def edit
    @seatings = Seating.where(room_id: @room.id)

    @responseObject = Array[]

    (0..@room.rows-1).each do
      @responseObject.push(Array[])
    end

    (0..@room.rows-1).each do |i|
      (0..@room.columns-1).each do |j|
        if ((i)*@room.columns + (j+1) <= @room.columns * @room.rows)
          @responseObject[i].push(@seatings[((i)*@room.columns + (j+1)-1)])
        end
      end
    end
  end

  # POST /rooms
  # POST /rooms.json
  def create
    @room = Room.new(room_params)

    respond_to do |format|
      if @room.save
        seatQuantity = (@room.rows * @room.columns)
        (1..seatQuantity).each do |i|
          @seating = Seating.create! slot: true,
                                     room_id: @room.id
          @seating.save
        end
        format.html { redirect_to edit_room_path(@room), notice: 'Room was successfully created.' }
        format.json { render :show, status: :created, location: @room }
      else
        format.html { render :new }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rooms/1
  # PATCH/PUT /rooms/1.json
  def update
    respond_to do |format|
      if @room.update(room_params)
        format.html { redirect_to @room, notice: 'Room was successfully updated.' }
        format.json { render :show, status: :ok, location: @room }
      else
        format.html { render :edit }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rooms/1
  # DELETE /rooms/1.json
  def destroy
    @room.destroy
    respond_to do |format|
      format.html { redirect_to rooms_url, notice: 'Room was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_room
    @room = Room.find(params[:id])
  end


  # Never trust parameters from the scary internet, only allow the white list through.
  def room_params
    params.require(:room).permit(:rows, :columns, :name)
  end
end
