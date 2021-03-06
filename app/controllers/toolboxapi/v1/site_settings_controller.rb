module Toolboxapi
  module V1
    class SiteSettingsController < ApplicationController
      skip_before_filter :redirect_to_login_if_required, :check_xhr
      protect_from_forgery except: :update

      respond_to :json

      def index
        respond_with SiteSetting.all_settings
      end

      def show
        respond_with SiteSetting.send(params[:id])
      end

      def update
        raise ActionController::ParameterMissing.new(:value) unless params.has_key?(:value)
        SiteSetting.send("#{params[:id]}=", params[:value])
        render nothing: true
      end
    end
  end
end
