class UsersController < ApplicationController
    before_action :find_user, only:[:show, :edit, :update, :destroy]

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

private 
    def user_params
        params.require(:user).permit(:username, :email, :password)
    end

    def find_user
        @user = User.find(params[:id])
    end
end