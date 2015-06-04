module Guachiman
  module Authorizable
    extend ActiveSupport::Concern

    included do
      before_action :authorize
      helper_method :authorization
    end

    def current_user
      nil
    end

    private

    def authorization
      @authorization ||= self.class.parents.first::Authorization.new(current_user)
    end

    def current_resource
      nil
    end

    def authorize
      unauthorized unless authorization.allow?(controller_name.to_sym, action_name.to_sym, current_resource)
    end

    def unauthorized
      raise UnauthorizedError.new(controller_name, action_name, current_resource)
    end
  end

  class UnauthorizedError < StandardError
    attr_reader :controller, :action, :resource

    def initialize(controller, action, resource)
      @controller = controller
      @action     = action
      @resource   = resource

      super("Unauthorized: #{ controller }##{ action } (#{ resource.inspect })")
    end
  end
end
