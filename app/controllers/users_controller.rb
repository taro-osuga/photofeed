class UsersController < ApplicationController
    before_action :ensure_correct_user, {only: [:show, :edit, :update]}

    def show
        @user = User.find(params[:id])
    end

    def new
        @user = User.new
    end
    def create
        @user = User.new(user_params)
        
        if @user.save
            session[:user_id] = @user.id
            redirect_to user_path(@user.id)
          else
            render :new
        end
    end

    def index
        @users = User.all.order(created_at: :desc)
    end

    def edit
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])
        if @user.update(user_params)
            redirect_to user_path, notice: "ユーザー情報を修正しました"
        else
            render :edit
        end
    end
    
    private
  
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation,:image_name)
    end

    def ensure_correct_user
        @user = User.find(params[:id])
        if current_user.id != @user.id
          flash[:notice] = "権限がありません"
          redirect_to feeds_path
        end
    end

end