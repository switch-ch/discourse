module Toolboxapi
  module V1
    class UsersController < ApplicationController
      skip_before_filter :redirect_to_login_if_required, :check_xhr, :verify_authenticity_token

      respond_to :json

      def index
        respond_with User.pluck(:email)
      end

      def show
        @aai_user = AaiUserInfo.find_by_unique_id(params[:id])
        respond_with @aai_user.user
      end

      def create
	@aai_user = AaiUserInfo.find_by_unique_id(params[:id])
        if @aai_user
	  update_user @aai_user
        else	
	  user = User.new_from_params(params)
	  user.username = UserNameSuggester.suggest(params[:username])
          user.moderator = params[:moderator]
          user.active = true
          user.approved = true
          user.save!
        end
	render nothing: true
      end

      def update
        @aai_user = AaiUserInfo.find_by_unique_id(params[:id])
        if @aai_user
	  update_user @aai_user
          # TODO: give some error back for else?
        end
        render nothing: true
      end
      
      def update_user aai_user
          @aai_user.user.moderator = params[:moderator]
	  @aai_user.user.blocked = false
	  @aai_user.user.banned_at = nil
          @aai_user.user.banned_till = nil
          @aai_user.user.save!
      end

      def destroy
        @aai_user = AaiUserInfo.find_by_unique_id(params[:id])
	@aai_user.user.blocked = true
        @aai_user.user.banned_at = DateTime.now
	@aai_user.user.banned_till = DateTime.new(2500)
        @aai_user.user.save!
	render nothing: true
      end
#      private
#       def confirm_username(username)
#	  user_check = User.find_by_username_or_email(username)
#	  while user_check do
#	    username = username + "1"
#	    user_check = User.find_by_username_or_email(username)
#         end
#	  username
#        end
    end
  end
end
