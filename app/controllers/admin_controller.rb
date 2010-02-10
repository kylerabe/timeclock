class AdminController < ApplicationController
  before_filter :authorize, :except => [:login_form, :login_validate]

  # GET /admin
  def index
    @admins = Admin.all
    @people = Person.all
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /admin/new
  def new
    @admin = Admin.new
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /admin/1/edit
  def edit
    @admin = Admin.find(params[:id])
  end

  # POST /admin
  def create
    # :new_password supplied but must be saved as :password
    params[:admin][:password] = params[:admin][:new_password]
    @admin = Admin.new(params[:admin])
    respond_to do |format|
      if @admin.save
        flash[:notice] = 'Admin was successfully created.'
        format.html { redirect_to(admin_index_url) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /admin/1
  def update
    # :new_password supplied but must be saved as :password unless it's blank (i.e., not updated)
    params[:admin][:password] = params[:admin][:new_password] unless params[:admin][:new_password].empty?
    @admin = Admin.find(params[:id])
    respond_to do |format|
      if @admin.update_attributes(params[:admin])
        flash[:notice] = 'Admin was successfully updated.'
        format.html { redirect_to(admin_index_url) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /admin/1
  def destroy
    @admin = Admin.find(params[:id])
    @admin.destroy
    respond_to do |format|
      format.html { redirect_to(admin_index_url) }
    end
  end

  def login_form
    respond_to do |format|
      format.html { render 'login.html' }
    end
  end

  def login_validate
    @admin = Admin.find_by_username(params[:username])
    if @admin && @admin.password == params[:password]
      session[:admin_id] = @admin.id
      redirect_to admin_index_url
    else
      flash[:notice] = "Invalid login. Please try again."
      redirect_to login_form_url
    end
  end

  def logout
    reset_session
    flash[:notice] = "You have successfully logged out."
    respond_to do |format|
      format.html { redirect_to people_url }
    end
  end

end
