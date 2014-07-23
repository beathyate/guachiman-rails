module Guachiman
  module Authorizable
    extend ActiveSupport::Concern

    included do
      before_action :authorize, unless: :skip_authorization?
    end

    def authorization
      @authorization ||= Authorization.new(current_user)
    end

    def current_user
      raise NotImplementedError
    end

    def current_resource
      nil
    end

    def skip_authorization?
      false
    end

    def authorize
      authorized = authorization.allow?(controller_name, action_name, current_resource)

      after_authorization(authorized)
    end

    def after_authorization(authorized)
      return true if authorized

      if request.get? && !request.xhr?
        redirect_to root_path, alert: t(:not_authorized)
      else
        render nothing: true, status: :unauthorized
      end
    end
  end
end
