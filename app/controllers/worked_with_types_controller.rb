class WorkedWithTypesController < ApplicationController
  load_and_authorize_resource
  
  def index
    @worked_with_types = WorkedWithType.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @worked_with_type }
    end
  end

  def show
    @worked_with_type = worked_with_type.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @publisher }
    end
  end

  def new
    @worked_with_type = worked_with_type.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @worked_with_type }
    end
  end

  def edit
    @worked_with_type = worked_with_type.find(params[:id])
  end

  def create
    @publisher = Publisher.new(params[:publisher])

    respond_to do |format|
      if @publisher.save
        format.html { redirect_to(@publisher, :notice => 'Publisher was successfully created.') }
        format.xml  { render :xml => @publisher, :status => :created, :location => @publisher }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @publisher.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @publisher = Publisher.find(params[:id])

    respond_to do |format|
      if @publisher.update_attributes(params[:publisher])
        format.html { redirect_to(@publisher, :notice => 'Publisher was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @publisher.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @publisher = Publisher.find(params[:id])
    @publisher.destroy

    respond_to do |format|
      format.html { redirect_to(publishers_url) }
      format.xml  { head :ok }
    end
  end
end
