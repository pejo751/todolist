class HomeController < ApplicationController
  before_action :authenticate_user!

  expose(:tasks)

  def index; end

end
