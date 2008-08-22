class UsersController
  include Mack::Controller
  
  before_filter :authorized?, :only => [:edit, :update, :delete]
  
  # GET /users
  def index
    @users = User.all
  end

  # GET /users/1
  def show
    @user = User.get(params[:id])
  end

  # GET /users/new
  def new
    # @user = User.new
    render(:action, :no_registrations)
  end

  # GET /users/1/edit
  def edit
    @user = User.get(params[:id])
    return redirect_to(login_url) if @user != current_user
  end

  # POST /users
  def create
    render(:action, :no_registrations)
    # @user = User.new(params[:user])
    # if @user.save
    #   session[:user_id] = @user.id 
    #   rtu = session[:return_to_url] || home_page_url
    #   session.delete(:return_to_url)
    #   redirect_to(rtu)
    # else
    #   render(:action, "new")
    # end
  end

  # PUT /users/1
  def update
    @user = User.get(params[:id])
    return redirect_to(login_url) if @user != current_user
    if @user.update_attributes(params[:user])
      redirect_to(users_show_url(:id => @user))
    else
      render(:action, "edit")
    end
  end

  # DELETE /users/1
  def delete
    @user = User.get(params[:id])
    @user.destroy
    redirect_to(users_index_url)
  end
  
  def login
    @user = User.new
  end
  
  def do_login
    @user = User.authenticate(params[:user][:username], params[:user][:password])
    if @user
      session[:user_id] = @user.id
      rtu = session[:return_to_url] || home_page_url
      session.delete(:return_to_url)
      redirect_to(rtu)
    else
      @user = User.new(params[:user])
      tell[:notice] = "Authentication Error. Username and/or password was incorrect."
      render(:action, :login)
    end
  end 

end
