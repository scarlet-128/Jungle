class Admin::DashboardController < ApplicationController
  
  http_basic_authenticate_with name: ENV['ADMIN_USERNAME'], password: ENV['ADMIN_PASSWORD']
  def show
  #   logger.debug "env:#{ENV['ADMIN_USERNAME']}"
  # puts ENV['ADMIN_PASSWORD']
    @number_of_products = Product.all.count
    @number_of_categories = Category.all.length
  end
end
