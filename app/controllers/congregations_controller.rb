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

  def destroy
    @congregation.destroy
    redirect_to congregations_url, notice: 'Congregation was successfully destroyed.'
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
