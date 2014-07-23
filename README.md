Guachiman for Rails
===================

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

Upgrade Notice
--------------

**Version 1.0.0 is incompatible with version =< 0.3.2.**

Usage
-----

Run `rails g guachiman:install`

This will generate a `authorization.rb` file in `app/models`.

Include `Guachiman::Authorizable` in `ApplicationController` and implement a `current_user` method there.

```ruby
# app/controllers/application_controller.rb

include Guachiman::Authorizable

def current_user
  @current_user ||= User.find_by_auth_token(cookies[:auth_token]) if cookies[:auth_token]
end
```

You can also override these methods to change the behaviour, for example:

### To skip authorization for admins

Defaults to `false`.

```ruby
def skip_authorization?
  current_user.admin?
end
```

### To handle what happens after the authorization takes place

This is the default implementation. You can modify it or break it up if you need to authorise
parameters, redirect to a different page or use a different flash key (for example).

```ruby
def after_authorization(authorized)
  return true if authorized

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

  def initialize(user)
    if @current_user = user
      user_authorization
    else
      guest_authorization
    end
  end

private

  def guest_authorization
    allow :sessions, [:new, :create]
    allow :users,    [:new, :create]
  end

  def user_authorization
    guest_authorization

    allow :users, [:show, :edit, :update] do |user|
      @current_user.id == user.id
    end
  end
end
```

The method `#current_resource` will default to nil but you can override in the controllers:

```ruby
class UsersController < ApplicationController
  # ...

  def current_resource
    @user ||= params[:id].present? ? User.find(params[:id]) : User.new
  end
end
```

License
-------

MIT
