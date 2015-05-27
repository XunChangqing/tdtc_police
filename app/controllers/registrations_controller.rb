require "application_helper"
class RegistrationsController < ApplicationController
  before_filter CASClient::Frameworks::Rails::Filter, except: [:signup, :reset_password, :logout, :create]
  layout "welcome", :only => [:signup]
  def signup
    @user = User.new
  end

  def reset_password
  end

  def logout
    CASClient::Frameworks::Rails::Filter.logout(self)
  end

  def create
    @user = User.new(params.require(:user).permit(:username, :orgnization, :password, :password_confirmation))

    respond_to do |format|
      if @user.save
        #format.html { redirect_to welcome_index_url, notice: t("user.created_successfully") }
        @user_log = UserLog.create(user: @user, operation: 'user.log.op.signup')
        format.html { render :create}
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :signup}
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @user = current_user
    @authority_change_request = AuthorityChangeRequest.new(user: @user, src_authority: @user.roles_mask, dst_authority: @user.roles_mask)
    @acrs = AuthorityChangeRequest.where(user_id: @user.id)
    respond_to do |format|
      if  @user.update(params.require(:user).permit(:email, :phonenumber, :password, :password_confirmation))
        #format.html { redirect_to @user, notice: t("user.update_successfully")}
        #@notice = t 'user.password_updated_successfully'
        @user_log = UserLog.create(user: @user, operation: 'user.log.op.modify_user')
        format.html { render :profile }
        format.json { render :show, status: :ok, location: @user }
      else
        #@notice = t 'user.oldpassword_error'
        format.html { render :profile }
        #format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def profile
    @user = current_user
    @authority_change_request = AuthorityChangeRequest.new(user: @user, src_authority: @user.roles_mask, dst_authority: @user.roles_mask)
    @acrs = AuthorityChangeRequest.where(user_id: @user.id)
  end

  def edit_profile
  end
end
