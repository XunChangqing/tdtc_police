class AuthorityChangeRequestsController < ApplicationController
  load_and_authorize_resource 
  before_filter CASClient::Frameworks::Rails::Filter 
  before_action :set_authority_change_request, only: [:show, :edit, :update, :accept, :reject, :delete, :destroy]

  # GET /authority_change_requests
  # GET /authority_change_requests.json
  def index
    @condition = {}
    @condition[:orgnization] = current_user.orginization unless current_user.orgnization == User::ORGS[0]
    @condition[:status] = params[:status] if params[:status] and AuthorityChangeRequest::STATUS.include? params[:status]
    @acrs = AuthorityChangeRequest.where @condition
  end

  # GET /authority_change_requests/1
  # GET /authority_change_requests/1.json
  def show
  end

  # GET /authority_change_requests/new
  def new
    @authority_change_request = AuthorityChangeRequest.new
  end

  # GET /authority_change_requests/1/edit
  def edit
  end

  # POST /authority_change_requests
  # POST /authority_change_requests.json
  def create
    #Rails.logger.info "-------->>>>>>>>>>>>>>>"
    #Rails.logger.info authority_change_request_params
    #Rails.logger.info params
    @authority_change_request = AuthorityChangeRequest.new(authority_change_request_params)
    @authority_change_request.user = current_user
    @authority_change_request.src_authority = current_user.roles_mask

    respond_to do |format|
      if @authority_change_request.save
        #format.html { redirect_to @authority_change_request, notice: 'Authority change request was successfully created.' }
        @user_log = UserLog.create user: @authority_change_request.user, operation: 'user.log.op.role_change_request'
        format.html { redirect_to registrations_profile_path(current_user)}
        format.json { render :show, status: :created, location: @authority_change_request }
      else
        format.html { render :new }
        format.json { render json: @authority_change_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /authority_change_requests/1
  # PATCH/PUT /authority_change_requests/1.json
  def update
    respond_to do |format|
      if @authority_change_request.update(authority_change_request_params)
        format.html { redirect_to @authority_change_request, notice: 'Authority change request was successfully updated.' }
        format.json { render :show, status: :ok, location: @authority_change_request }
      else
        format.html { render :edit }
        format.json { render json: @authority_change_request.errors, status: :unprocessable_entity }
      end
    end
  end

  def delete
    if @authority_change_request.status == 'user.acr.status.submited'
      @authority_change_request.destroy
      @user_log = UserLog.create user: @authority_change_request.user, operation: 'user.log.op.role_change_cancel'
    end
    redirect_to registrations_profile_path(current_user)
  end

  def accept
    if @authority_change_request.status == 'user.acr.status.submited'
      @authority_change_request.status = 'user.acr.status.accepted'
      @user = @authority_change_request.user 
      @user.roles_mask = @authority_change_request.dst_authority
      @user.save
      @authority_change_request.save
      @user_log = UserLog.create user: current_user, operation: 'user.log.op.accept_role_change', target_user: @user.username
    end
    redirect_to authority_change_requests_url
  end

  def reject
    if @authority_change_request.status == 'user.acr.status.submited'
      @authority_change_request.status = 'user.acr.status.rejected'
      @authority_change_request.save
      @user_log = UserLog.create user: current_user, operation: 'user.log.op.reject_role_change', target_user: @authority_change_request.user.username
    end
    redirect_to authority_change_requests_url
  end

  # DELETE /authority_change_requests/1
  # DELETE /authority_change_requests/1.json
  def destroy
    @user_log = UserLog.create user: current_user, operation: 'user.log.op.destroy_role_change', target_user: @authority_change_request.user.username
    @authority_change_request.destroy
    respond_to do |format|
      format.html { redirect_to authority_change_requests_url, notice: 'Authority change request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_authority_change_request
    @authority_change_request = AuthorityChangeRequest.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def authority_change_request_params
    params.require(:authority_change_request).permit(:user_id, :src_authority, :dst_authority, :user_remark, :manager_remark, :status, dst_roles: [])
  end
end
