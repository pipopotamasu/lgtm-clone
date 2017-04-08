require 'rails_helper'

module Helpers
  def login(user)
    session[:user_id] = user.id
  end
end
