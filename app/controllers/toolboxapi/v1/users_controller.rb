module Toolboxapi
  module V1
    class UsersController < ApplicationController
      skip_before_filter :redirect_to_login_if_required, :check_xhr
      respond_to :json

      def index
        respond_with User.all
      end

      def show
        @aai_user = AaiUserInfo.find_by_unique_id(params[:id])
        respond_with @aai_user.user
      end

      def create
        user = User.new_from_params(params)
        user.save
        render nothing: true
      end

    end
  end
end
