guachiman-rails
===============

Basic Authorization gem for rails based on [RailsCast #385 Authorization from Scratch][1] by Ryan Bates.
Built on top of [guachiman][2].

[![Codeship Status for goddamnhippie/guachiman-rails][3]][4]

[1]: http://railscasts.com/episodes/385-authorization-from-scratch-part-1
[2]: https://github.com/goddamnhippie/guachiman
[3]: https://www.codeship.io/projects/06034ef0-f456-0131-65bd-5a054a318c0e/status
[4]: https://www.codeship.io/projects/28084

Installation
------------

Add this line to your application's Gemfile:

```ruby
gem 'guachiman-rails'
```

And then execute:

```bash
$ bundle
```

Or install it directly:

```bash
$ gem install guachiman-rails
```

Usage
-----

Run `rails g guachiman:install`

This will generate a `authorization.rb` file in `app/models`.

Include `Guachiman::Authorizable` in `ApplicationController` and optionally implement a
`current_user` method there (it defaults to `nil`).

```ruby
# app/controllers/application_controller.rb

include Guachiman::Authorizable

def current_user
  @current_user ||= User.find_by_auth_token(cookies[:auth_token]) if cookies[:auth_token]
end
```

### Skip authorization

```ruby
class UsersController < ApplicationController
  skip_before_action :authorize, if: :admin?
  # ...
  private

  def admin?
    current_user && current_user.admin?
  end
end
```

### Handle authorization failure

The default implementation is to raise `Guachiman::UnauthorizedError`. You can rescue the error with a regular
Rails `rescue_from` call or override the `#unauthorized` method directly:

```ruby
def unauthorized
  if request.get? && !request.xhr?
    session[:next] = request.url
    redirect_to root_path, alert: t(:unauthorized)
  else
    render nothing: true, status: :unauthorized
  end
end
```

Now you can describe your authorization object in this way:

```ruby
class Authorization
  include Guachiman

  def initialize(current_user)
    allow :sessions, :new, :create
    allow :users,    :new, :create

    allow :users, :show, :edit, :update do |user|
      current_user && current_user.id == user.id
    end
  end
end
```

The method `#current_resource` will default to nil but you can override in the controllers:

```ruby
class UsersController < ApplicationController
  # ...
  private

  def current_resource
    @user ||= User.find(params[:id]) if params[:id].present?
  end
end
```

License
-------

MIT
