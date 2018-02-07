class CongregationsController < ApplicationController
  before_action :set_congregation, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  def index
    @congregations = Congregation.all
  end

  def show
  end

  def new
    @congregation = Congregation.new
  end

  def edit
  end

  # POST /congregations
  def create
    @congregation = Congregation.new(congregation_params)

    if @congregation.save
      redirect_to @congregation, notice: 'Congregation was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @congregation.update(congregation_params)
      redirect_to @congregation, notice: 'Congregation was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def disable
    @congregation = Congregation.find(params[:format])
    if @congregation.active == "Y" 
      if @congregation.update(active: "N")
        redirect_to(congregations_path, :notice => "#{@congregation.name.titleize} was disabled.")
      else
        render :action => "edit"
      end
    else
      redirect_to(congregations_path, :alert => "#{@congregation.name.titleize} has already been disabled.")
    end
  end

  def enable
    @congregation = Congregation.find(params[:format])
    if @congregation.active == "N" 
      if @congregation.update(active: "Y")
        redirect_to(congregations_path, :notice => "#{@congregation.name.titleize} was enabled.")
      else
        render :action => "edit"
      end
    else
      redirect_to(congregations_path, :alert => "#{@congregation.name.titleize} is already enabled.")
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_congregation
      @congregation = Congregation.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def congregation_params
      params.require(:congregation).permit(:name,:active)
    end
end
