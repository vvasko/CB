class WelcomeController < ApplicationController
  before_filter :find_item, only: [:show]

  def index
    if params[:product].present?
      @cocktails = Cocktail.all_with_includes_by_product params[:product]
    else
      @cocktails = Cocktail.all_with_includes
    end

    @cocktails = filter_by :type
    @cocktails = @cocktails.group_by{ |c| c.type }

  end

  def show

  end

  private
  def find_item
    @cocktail= Cocktail.find_with_includes params[:id]
  end

  def filter_by field
    if params[field].present?
      @cocktails = @cocktails.select { |v| v.send(field) == params[field] }
    end

    @cocktails
  end


end
