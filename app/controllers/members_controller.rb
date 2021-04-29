class MembersController < ApplicationController
  before_action :set_member, only: %i[ show edit update destroy ]

  # GET /Members or /Members.json
  def index
    @members = current_tenant.members.includes(:user)
  end

  # GET /Members/1 or /Members/1.json
  def show
  end

  # GET /Members/new
  def new
    @user = User.new
  end

  # POST /Members or /Members.json
  def create
    @user = User.find_by_email(user_params[:email])
    if @user.nil?
      @user = User.new(user_params.merge(password: "secret"))
      if @user.save 
        @member = @user.members.create(account_id: currrent_tenant.id)
        @user.send(:generate_confirmation_token)
        Devise::Mailer.confirmation_instructions(@user, @user.instance_variable_get(:@raw_confirmation_token))
        flash[:notice] =  "Email invitation sent to #{@user.email}." 
        redirect_to members_path
      else
        render :new
      end
    else
      if !Member.exists?(user_id: @user.id)
        @member = @user.members.create(account_id: currrent_tenant.id)
        flash[:notice] = "#{@user.email} added succesfully"
        redirect_to members_path
      else
        flash.now[:alert] = "#{@user.email} is a member already"
        render :new
      end
    end
  end

  # DELETE /Members/1 or /Members/1.json
  def destroy
    @member.destroy
    respond_to do |format|
      format.html { redirect_to members_url, notice: "member was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_member
    @member = Member.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:email)
  end
end