class WelcomeController < ApplicationController
  def index
    @eposts = Post.all
  end
end
