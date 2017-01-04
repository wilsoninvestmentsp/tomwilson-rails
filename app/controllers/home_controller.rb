class HomeController < ApplicationController
  def index
    @testimonies = Testimony.all
  end
end