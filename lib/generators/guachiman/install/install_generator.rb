module Guachiman
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      desc "Create Authorization model"
      source_root File.expand_path("../templates", __FILE__)

      def copy_authorization_model
        template("authorization.rb", "app/models/authorization.rb")
      end
    end
  end
end
