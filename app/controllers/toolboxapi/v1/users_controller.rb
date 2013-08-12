module Toolboxapi
  module V1
    class UsersController < ApplicationController
      skip_before_filter :redirect_to_login_if_required, :check_xhr, :verify_authenticity_token

      respond_to :json

      def index
        respond_with User.pluck(:email)
        # respond_with User.all
        # respond_with User.first.email
      end

      def show
        @aai_user = AaiUserInfo.find_by_unique_id(params[:id])
        respond_with @aai_user.user
      end

      def create
        user = User.new_from_params(params)
        user.moderator = params[:moderator]
        user.active = true
        user.approved = true
        user.save!
        render nothing: true
      end

      def update
        @aai_user = AaiUserInfo.find_by_unique_id(params[:id])
        if @aai_user
          @aai_user.user.moderator = params[:moderator]
          @aai_user.user.save!
          # TODO: give some error back for else?
        end
        render nothing: true
      end

    end
  end
end
