class RentersController < ApplicationController
  before_filter :authenticate_user!

  before_action :set_renter, only: [:show, :edit, :update, :destroy]

  # GET /renters
  # GET /renters.json
  def index
    @renters = Renter.actual
    @renters = current_user.renters if current_user.has_role?(:manager)
    @renters = @renters.order('check_in')
  end

  # GET /renters/1
  # GET /renters/1.json
  def show

  end

  # GET /renters/new
  def new
    @renter = Renter.new
  end

  # GET /renters/1/edit
  def edit
  end

  # POST /renters
  # POST /renters.json
  def create
    @renter = Renter.new(renter_params)
    @renter.user = current_user

    respond_to do |format|
      if @renter.save
        format.html { redirect_to @renter, notice: 'Запись успешно добавлена.' }
        format.json { render action: 'show', status: :created, location: @renter }
      else
        format.html { render action: 'new' }
        format.json { render json: @renter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /renters/1
  # PATCH/PUT /renters/1.json
  def update
    respond_to do |format|
      if @renter.update(renter_params)
        format.html { redirect_to @renter, notice: 'Запись успешно обновлена.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @renter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /renters/1
  # DELETE /renters/1.json
  def destroy
    @renter.destroy
    respond_to do |format|
      format.html { redirect_to renters_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_renter
    @renter = Renter.find(params[:id])
    @renter = current_user.renters.find(params[:id]) if current_user.has_role?(:manager)
    @renter.create_order(current_user) if current_user.has_role?(:realtor) || current_user.has_role?(:vip_realtor)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def renter_params
    params.require(:renter).permit(:phone, :email, :guard_time, :town, :rooms, :amount, :сheck_in, :description)
  end
end
