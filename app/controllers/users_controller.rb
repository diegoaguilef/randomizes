class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :destroy, :update]
  def index
  	@users = User.all
  end

  def new
    @user = User.new
  end

  def edit
  	
  end

  def show
  	
  end

  def create
  	@user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.html {render :show}
        format.json {render json: @user}
      else
        format.html {render :new, notice: 'Hubo problemas al crear Usuario'}
        format.json {}
      end
    end
  end

  def destroy
    respond_to do |format|
      if @user.destroy
        format.html {redirect_to users_path, notice: 'Usuario Eliminado Correctamente'}
        format.json {render json: @user}
      else
        format.html {render :index, notice: 'Hubo problemas al Eliminar'}
        format.json {}
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html {render :show}
        format.json {render json: @user}
      else
        format.html {render :new, notice: 'Hubo problemas al crear Usuario'}
        format.json {}
      end
    end
  end

  private 

  def set_user
  	@user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name,:age,:birth_date, :cell_phone)
  end

end