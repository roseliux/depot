class StoreController < ApplicationController
  include CurrentCart
  before_action :set_cart
  before_action :set_counter, only: :index
  def index
    @products = Product.order(:title)
    session[:counter] += 1
  end

  private
  def set_counter
    if session[:counter].nil?
      session[:counter] = 0
    end
  end
end
