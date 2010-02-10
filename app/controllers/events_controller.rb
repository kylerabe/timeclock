class EventsController < ApplicationController
  before_filter :find_person_and_offset
  before_filter :authorize, :except => [:index, :punch_clock, :find_person]

  # GET /people/1/events
  def index
    @events = @person.events.pay_period_with_offset(@offset)
    unless @events.empty?
      beginning = @events.first.time
      if beginning.day <= 15
        @period_start = Date.new(beginning.year, beginning.month, 1)
      else
        @period_start = Date.new(beginning.year, beginning.month, 16)
      end
    end
  end

  # GET /people/1/events/new
  def new
    @event = @person.events.new
    flash[:offset] = @offset
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /people/1/events/1/edit
  def edit
    @event  = @person.events.find(params[:id])
    flash[:offset] = @offset
  end

  # POST /people/1/events
  def create
    @event = @person.events.new(params[:event])
    respond_to do |format|
      if @event.save
        flash[:notice] = 'Event was successfully created.'
        format.html { redirect_to person_events_url(@person, :offset => flash[:offset]) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # POST /people/1/punch_clock
  def punch_clock
    @event = @person.events.new(:time   => Time.now,
                                :action => @person.next_action)
    respond_to do |format|
      if @event.save
        flash[:notice] = "#{@person.full_name} clocked #{@event.action_name}."
        format.html { redirect_to people_url }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /people/1/events/1
  def update
    @event = @person.events.find(params[:id])
    respond_to do |format|
      if @event.update_attributes(params[:event])
        flash[:notice] = 'Event was successfully updated.'
        format.html { redirect_to person_events_url(@person, :offset => flash[:offset]) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /people/1/events/1
  def destroy
    @event = @person.events.find(params[:id])
    @event.destroy
    respond_to do |format|
      format.html { redirect_to person_events_url(@person) }
    end
  end

  private

  def find_person_and_offset
    return(redirect_to(people_url)) unless params[:person_id]
    @person = Person.find(params[:person_id])
    params[:offset] ? @offset = params[:offset].to_i : @offset = 0
  end
end
