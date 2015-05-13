class PasswordResetRequestsController < ApplicationController
  load_and_authorize_resource except: [:new, :create]
  before_filter CASClient::Frameworks::Rails::Filter, except: [:new, :create]
  before_action :set_password_reset_request, only: [:show, :edit, :update, :destroy]

  # GET /password_reset_requests
  # GET /password_reset_requests.json
  def index
    @condition = {}
    @condition[:orgnization] = current_user.orginization unless current_user.orgnization == User::ORGS[0]
    @condition[:status] = params[:status] if params[:status] and PasswordResetRequest::STATUS.include? params[:status]
    @password_reset_requests = PasswordResetRequest.where @condition
  end

  # GET /password_reset_requests/1
  # GET /password_reset_requests/1.json
  def show
  end

  # GET /password_reset_requests/new
  def new
    @password_reset_request = PasswordResetRequest.new
  end

  # GET /password_reset_requests/1/edit
  def edit
  end

  # POST /password_reset_requests
  # POST /password_reset_requests.json
  def create
    @user = User.where(params.permit('username')).first
    @password_reset_request = PasswordResetRequest.new({user: @user}.merge(params.require(:password_reset_request).permit(:remark)))

    respond_to do |format|
      if @password_reset_request.save
        #format.html { redirect_to @password_reset_request,  notice: 'Password reset request was successfully created.', status:  'user.prr.status.submit'}
        #format.html { redirect_to registrations_profile_path}
        @user_log = UserLog.create(user: @user, operation: 'user.log.op.password_reset')
        format.html { redirect_to root_path}
        format.json { render :show, status: :created, location: @password_reset_request }
      else
        format.html { render :new }
        format.json { render json: @password_reset_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /password_reset_requests/1
  # PATCH/PUT /password_reset_requests/1.json
  def update
    @in_params = password_reset_request_params
    @in_params[:status] = 'user.prr.status.processed'
    respond_to do |format|
      if @password_reset_request.update(@in_params)
        @user_log = UserLog.create(user: current_user, operation: 'user.log.op.process_reset', target_user: @password_reset_request.user.username)
        format.html { redirect_to password_reset_requests_path, notice: 'Password reset request was successfully updated.' }
        format.json { render :show, status: :ok, location: @password_reset_request }
      else
        format.html { render :edit }
        format.json { render json: @password_reset_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /password_reset_requests/1
  # DELETE /password_reset_requests/1.json
  def destroy
    @password_reset_request.destroy
    respond_to do |format|
      @user_log = UserLog.create(user: current_user, operation: 'user.log.op.destroy_reset', target_user: @password_reset_request.user.username)
      format.html { redirect_to password_reset_requests_url, notice: 'Password reset request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_password_reset_request
      @password_reset_request = PasswordResetRequest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def password_reset_request_params
      params.require(:password_reset_request).permit(:user_id, :remark, :status)
    end
end
