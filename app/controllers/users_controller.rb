#require "application_helper"
class UsersController < ApplicationController
  load_and_authorize_resource
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_filter CASClient::Frameworks::Rails::Filter

  # GET /users
  # GET /users.json
  def index
    @condition = {}
    @condition[:orgnization] = current_user.orginization unless current_user.orgnization == User::ORGS[0]
    @condition[:status] = params[:status] if params[:status] and User::STATUS.include? params[:status]
    @users = User.where @condition
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        @user_log = UserLog.create user: current_user, operation: 'user.log.op.new_user', target_user: @user.username
        format.html { redirect_to @user, notice: t("user.created_successfully") }
        format.json { render :show, status: :created, location: @user }
        #format.js {}
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        #format.html { redirect_to @user, notice: t("user.updated_successfully")}
        @user_log = UserLog.create user: current_user, operation: 'user.log.op.modify_user', target_user: @user.username
        format.html { redirect_to users_url}
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user_log = UserLog.create user: current_user, operation: 'user.log.op.destroy_user', target_user: @user.username
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def approve
    @user.status = 'user.status.normal'
    @user.save
    @user_log = UserLog.create user: current_user, operation: 'user.log.op.approve', target_user: @user.username
    respond_to do |format|
      format.html{ redirect_to users_url, notice: 'User sign up is approved!'}
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :email, :orgnization, :phonenumber, :status, :password, :password_confirmation, roles:[])
    end
end
