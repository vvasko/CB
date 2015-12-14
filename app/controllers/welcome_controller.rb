class WelcomeController < ApplicationController

  include WelcomeHelper

  before_filter :find_item, only: [:show]

  before_action :verify_params!, only: [:add_to_cart]
  before_action :sum_to_pay, only: [:index,:show]
  before_action :get_current_table, only: [:index]

  def index
    puts "welcome controller"
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

  def add_to_cart
    #check cocktail exists (verify_params)
    Order.add_cocktail_to_order @cocktail_id
    redirect_to action: 'index'
  end

  def call_waiter
    current_table = 2 #TODO: get current table
    Table
        .where(:id => current_table)
        .update_all(:status => Table.statuses[:waiting])

    redirect_to_back
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
    @cocktails = filter_by(field)
    #else
    @cocktails = @cocktails.group_by { |c| c.send(field) }
    #end

  end

  def redirect_to_back(error_message='')
    if error_message.present?
      flash[:warning] = error_message
    end
    redirect_to request.referer.blank? ? root_url : request.referer
  end

  def verify_params!
    @cocktail_id = params[:id]
    unless @cocktail_id.blank?
      if Cocktail.find_by(id: @cocktail_id).blank?
        redirect_to_back "Can not find cocktail with id #{@product_id}"
      end
    end
  end

  def sum_to_pay
    @sum = Order.sum_to_pay
   
  end

  def get_current_table
<<<<<<< HEAD
    set_current_table_id(4)
    @currrent_table = get_current_table_id
  end
=======
    # current_table = 2 #TODO: get current table
    # @currrent_table = current_table
    current_table_id= 4
    @current_table = current_table_id
    puts "currrent_table = #{@current_table}"
   end
>>>>>>> 629234322d3fc2661d01f9d3c7bcb41bfcb5e2f2
end
