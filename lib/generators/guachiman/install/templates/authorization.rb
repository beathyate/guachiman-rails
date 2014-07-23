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
    # allow :sessions, [:new, :create]
  end

  def user_authorization
    guest_authorization

    # allow :users, [:show, :edit, :update] do |user_id|
    #   @current_user.id == user_id
    # end
  end
end
