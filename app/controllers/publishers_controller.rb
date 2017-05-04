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
    @territories_checked_out = {}
    # Get history of territories that have been checked out but not checked in.
    @publisher.checkouts.each do |hist|
      if not hist.checked_in
        @territories_checked_out[":#{hist.id}"] = {
            :name => "#{hist.territory.name}",
            :checkedoutat => "#{hist.checked_out.strftime("%m-%d-%Y")}",
            :age_months => "#{ (Date.today.year * 12 + Date.today.month) - (hist.checked_out.year * 12 + hist.created_at.month) }",
          }
        
      end
    end
    
    # Get full history.
    @publisher_history = {}
    @publisher.checkouts.each do |hist|
      if hist.checked_in
        months = (hist.checked_in.year * 12 + hist.checked_in.month) - (hist.checked_out.year * 12 + hist.checked_out.month)
        days_co = hist.checked_out.day.to_f / (Time.days_in_month hist.checked_out.month, hist.checked_out.year)
        days_ci = hist.checked_in.day.to_f / (Time.days_in_month hist.checked_in.month) 
        
        puts "#{months.inspect}"
        puts "#{days_co.inspect}"
        puts "#{days_ci.inspect}"
        @publisher_history[":#{hist.id}"] = {
          :name => "#{hist.territory.name}",
          :age => "#{months + days_co + days_ci}",
          :checkout => "#{hist.checked_out.strftime("%m-%d-%Y")}",
          :checkin => "#{hist.checked_in.strftime("%m-%d-%Y")}",
          :workedwith => "#{hist.worked_with_type.name}"
        }
      end
    end
    
    @publisher_history = @publisher_history.sort_by { |hist, date| date }

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
