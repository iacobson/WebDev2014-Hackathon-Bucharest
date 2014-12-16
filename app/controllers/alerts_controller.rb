class AlertsController < ApplicationController
  before_action :set_alert, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @alerts = Alert.all
    respond_with(@alerts)
  end

  def show
    respond_with(@alert)
  end

  def new
    @alert = Alert.new
    respond_with(@alert)
  end

  def edit
  end

  def create
    @alert = Alert.new(alert_params)
    @alert.save
    #@cnp_id = params[:cnp_now].to_i

    #puts "^^^^^^^^^^^^^^^^^^^^^^^"
    #puts @cnp_id

    redirect_to showvoters_path
  end

  def update
    @alert.update(alert_params)
    respond_with(@alert)
  end

  def destroy
    @alert.destroy
    respond_with(@alert)
  end

  private
    def set_alert
      @alert = Alert.find(params[:id])
    end

    def alert_params
      params.require(:alert).permit(:description)
    end
end
