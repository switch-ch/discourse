module Toolboxapi
  module V1
    class UsersController < ApplicationController
      respond_to :json
      
      def show
        respond_with User.find_by_username_or_email(params[:id])
      end

      def index
        respond_with User.all
      end
    end
  end
end
