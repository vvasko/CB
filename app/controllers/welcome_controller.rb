class WelcomeController < ApplicationController
  before_filter :find_item, only: [:show]

  def index
    # puts params[:product]
    if params[:product].present?
      @cocktails = Cocktail.all_with_includes_by_product  params[:product]
      render :index
    else
      @cocktails = Cocktail.all_with_includes
    end

  end

  def show

  end

  private
  def find_item
    @cocktail= Cocktail.find_with_includes params[:id]
  end
end
