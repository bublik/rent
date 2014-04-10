class SettingsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_setting, only: [:show, :for_assign, :grant_access, :edit, :update, :destroy]

  ## GET /settings
  ## GET /settings.json
  def index
    redirect_to edit_setting_path(Setting.first)
  end
  #
  ## GET /settings/1
  ## GET /settings/1.json
  #def show
  #end
  #
  ## GET /settings/new
  #def new
  #  @setting = Setting.new
  #end

  # GET /settings/1/edit
  def edit
  end
  #
  ## POST /settings
  ## POST /settings.json
  #def create
  #  @setting = Setting.new(setting_params)
  #
  #  respond_to do |format|
  #    if @setting.save
  #      format.html { redirect_to @setting, notice: 'Setting was successfully created.' }
  #      format.json { render action: 'show', status: :created, location: @setting }
  #    else
  #      format.html { render action: 'new' }
  #      format.json { render json: @setting.errors, status: :unprocessable_entity }
  #    end
  #  end
  #end

  def grant_access
    state = if @setting.users.include?(params[:user_id]) && @setting.users = @setting.users - [params[:user_id]]
      'removed'
    else
      'created' if @setting.users << params[:user_id]
    end
    @setting.save

    respond_to do |format|
      format.js {
        render text: "$('.realtors #user_#{params[:user_id]} .btn').#{state.eql?('created') ? 'addClass' : 'removeClass' }('btn-success');"
      }
    end
  end

  def for_assign
    @users = User.with_role(params[:role])
    @assigned_user_ids = @setting.users.map(&:to_i)
    logger.debug(@assigned_user_ids.inspect)
  end

  # PATCH/PUT /settings/1
  # PATCH/PUT /settings/1.json
  def update
    respond_to do |format|
      if @setting.update(setting_params)
        format.html { redirect_to edit_setting_path(@setting), notice: 'Настройки сохранены.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @setting.errors, status: :unprocessable_entity }
      end
    end
  end

  ## DELETE /settings/1
  ## DELETE /settings/1.json
  #def destroy
  #  @setting.destroy
  #  respond_to do |format|
  #    format.html { redirect_to settings_url }
  #    format.json { head :no_content }
  #  end
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_setting
      @setting = Setting.first
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def setting_params
      params.require(:setting).permit(:autoopen, :autoopen_interval)
    end
end
