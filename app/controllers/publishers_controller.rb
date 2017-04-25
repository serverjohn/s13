class PublishersController < ApplicationController
  load_and_authorize_resource

  def publisher_params
    params.require(:publisher).permit(:first_name, :last_name, :email, :phone_number, :textmessage, :notes)
  end

  def index
    @publishers = Publisher.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @publishers }
    end
  end

  def show
    @publisher = Publisher.find(params[:id])

    @publisher_history = {}
    @publisher.checkouts.each do |hist|
      if hist.checked_in
        @publisher_history["hist_#{hist.id}".to_sym] = hist
        @publisher_history["hist_#{hist.id}".to_sym][:age] = hist.checked_in.to_date.month - hist.checked_out.to_date.month
      end
    end    
    @publisher_history = @publisher_history.sort_by { |k, v| v[:checked_out] }
    
    @territories_checked_out = {}
    @publisher.checkouts.each do |hist|
      if not hist.checked_in
        @territories_checked_out["hist_#{hist.id}".to_sym] = hist
        @territories_checked_out["hist_#{hist.id}".to_sym][:age] = Time.now.month - hist.checked_out.to_date.month
      end
    end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @publisher }
    end
  end

  def new
    @publisher = Publisher.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @publisher }
    end
  end

  def edit
    @publisher = Publisher.find(params[:id])
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
  
  def publisher_history

  end
end
