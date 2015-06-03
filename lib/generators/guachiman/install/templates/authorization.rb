class Authorization
  include Guachiman

  def initialize(current_user)
    # allow :sessions, :new, :create
    # allow :users,    :new, :create

    # allow :users, :show, :edit, :update do |user|
    #  current_user && current_user.id == user.id
    # end
  end
end
