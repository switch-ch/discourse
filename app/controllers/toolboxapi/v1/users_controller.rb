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
        # User.create_for_email(params[:email])
        user = User.new_from_params(params)
        user.save
        render nothing: true
      end

    end
  end
end
