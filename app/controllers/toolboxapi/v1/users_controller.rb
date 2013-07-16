module Toolboxapi
  module V1
    class UsersController < ApplicationController
      respond_to :json
      
      def show
        respond_with User.find(params[:id])
      end

      def index
        respond_with User.all
      end
    end
  end
end
