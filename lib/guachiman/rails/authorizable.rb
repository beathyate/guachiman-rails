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
      authorized = authorization.allow?(controller_name.to_sym, action_name.to_sym, current_resource)

      after_authorization(authorized)
    end

    def after_authorization(authorized)
      return true if authorized

      if request.get? && !request.xhr?
        session[:next] = request.url
        redirect_to root_path, alert: t(:unauthorized)
      else
        render nothing: true, status: :unauthorized
      end
    end
  end
end
