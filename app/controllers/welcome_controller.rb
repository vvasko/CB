class WelcomeController < ApplicationController
  before_filter :find_item, only: [:show]

  def index
    case
      when params.has_key?(:search)
        search_by_phrase
      when params.has_key?(:product)
        search_by_product
      else
        show_default
    end
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

  def show_default
    @cocktails = Cocktail.all_with_includes
    group_and_filter_by :type
  end


  def search_by_phrase
    @cocktails = {}
    @cocktails["name containing '#{params[:search].to_s}'"] = Cocktail.search_by_name(params[:search]).all_with_includes
    @cocktails["ingridient name containing '#{params[:search].to_s}'"] =
        Cocktail.search_by_ingridients_name(params[:search]).all_with_includes

  end

  def search_by_product
    if params[:product].present?
      @cocktails = Cocktail.all_with_includes_by_product params[:product]
    else
      @cocktails = Cocktail.all_with_includes
    end
    group_and_filter_by :type

  end

  def group_and_filter_by field
   # if params[field].present?
      @cocktails =  filter_by(field)
    #else
      @cocktails = @cocktails.group_by { |c| c.send(field) }
    #end

  end

end
