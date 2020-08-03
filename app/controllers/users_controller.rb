class UsersController < ApplicationController
    before_action :find_user, only:[:show, :edit, :update, :destroy]
    before_action :require_user, only: [:edit, :update]
    before_action :require_same_user, only: [:edit, :update, :destroy]
def new 
    @user = User.new
end

def edit
end

def show
end 

def index
    @users = User.paginate(page: params[:page], per_page: 5)
end

def create
    @user = User.new(user_params)
    if(@user.save)
        session[:user_id] = @user.id
        flash[:notice] = "Registered!"
        redirect_to articles_path
    else
        render 'new'
    end
end 

def update
    if @user.update(user_params)
        flash[:notice] = "Updated!"
        redirect_to @user
    else
        render 'edit'
    end
end

def destroy
    @user.destroy
    session[:user_id] =  nil if @user == current_user
    flash[:notice] = "Account deleted!"
    redirect_to articles_path
end

private 
    def user_params
        params.require(:user).permit(:username, :email, :password)
    end

    def find_user
        @user = User.find(params[:id])
    end

    def require_same_user
        if current_user != @user and !current_user.admin?
            flash[:alert] = "You can't edit this."
            redirect_to @user
        end
    end
end