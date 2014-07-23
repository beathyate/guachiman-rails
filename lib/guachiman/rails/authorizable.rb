module Guachiman
  module Authorizable
    extend ActiveSupport::Concern

    included do
      before_action :authorize
      helper_method :current_user
      helper_method :current_permission
      helper_method :current_resource
    end

    def current_user
      raise NotImplementedError
    end

    def current_permission
      @current_permission ||= Permission.new(current_user, request)
    end

    def current_resource
      nil
    end

    def authorize
      if current_permission.allow?(controller_name, action_name, current_resource)
        authorized
      else
        not_authorized
      end
    end

    def authorized
      if current_permission.allow_all?
        params.permit!
      else
        current_permission[:params].each { |k, attrs| params[k] = params.fetch(k, {}).permit(*attrs) }
      end
    end

    def not_authorized
      if request.get? && !request.xhr?
        redirect_to root_path, alert: t('flashes.not_authorized')
      else
        render nothing: true, status: :unauthorized
      end
    end
  end
end
