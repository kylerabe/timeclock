class PeopleController < ApplicationController
  before_filter :authorize, :except => [:index]

  # GET /people
  def index
    @people = Person.visible
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /people/new
  def new
    @person = Person.new
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /people/1/edit
  def edit
    @person = Person.find(params[:id])
  end

  # POST /people
  def create
    @person = Person.new(params[:person])
    respond_to do |format|
      if @person.save
        flash[:notice] = 'Person was successfully created.'
        format.html { redirect_to(admin_index_url) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /people/1
  def update
    @person = Person.find(params[:id])
    respond_to do |format|
      if @person.update_attributes(params[:person])
        flash[:notice] = 'Person was successfully updated.'
        format.html { redirect_to(admin_index_url) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /people/1
  def destroy
    @person = Person.find(params[:id])
    @person.destroy
    respond_to do |format|
      format.html { redirect_to(admin_index_url) }
    end
  end
end
