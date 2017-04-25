class WorkedWithTypesController < ApplicationController
  load_and_authorize_resource

  def worked_with_type_params
    params.require(:worked_with_type).permit(:name, :active)
  end
  
  def index
    @worked_with_types = WorkedWithType.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @worked_with_type }
    end
  end

  def show
    @worked_with_type = WorkedWithType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @worked_with_type }
    end
  end

  def new
    @worked_with_type = WorkedWithType.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @worked_with_type }
    end
  end

  def edit
    @worked_with_type = WorkedWithType.find(params[:id])
  end

  def create
    @worked_with_type = WorkedWithType.new(params[:worked_with_type])

    respond_to do |format|
      if @worked_with_type.save
        format.html { redirect_to(@worked_with_type, :notice => 'WorkedWithType was successfully created.') }
        format.xml  { render :xml => @worked_with_type, :status => :created, :location => @worked_with_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @worked_with_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @worked_with_type = WorkedWithType.find(params[:id])

    respond_to do |format|
      if @worked_with_type.update_attributes(params[:worked_with_type])
        format.html { redirect_to(@worked_with_type, :notice => 'WorkedWithType was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @worked_with_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @worked_with_type = WorkedWithType.find(params[:id])
    @worked_with_type.active = "N"
    puts "+++++++++++++++++++++++++++++++++++++++++++++++++++++"
    puts @worked_with_type.inspect
    respond_to do |format|
      if @worked_with_type.update_atributes(@worked_with_type)
        format.html { redirect_to(worked_with_types_url, :notice => 'WorkedWithType: #{@worked_with_type} has been marked as inactive.') }
        format.xml  { head :ok }
      end
        format.html { render :action => "show" }
        format.xml  { render :xml => @worked_with_type.errors, :status => :unprocessable_entity }
    end
  end
end
