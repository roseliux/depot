class StoreController < ApplicationController
  include CurrentCart
  skip_before_action :authorize
  before_action :set_cart
  before_action :set_counter, only: :index

  def index
    @products = Product.order(:title)
    session[:counter] += 1
  end

  private

  def set_counter
    session[:counter] = 0 if session[:counter].nil?
  end
end
