class OrderedCocktail < ActiveRecord::Base
  has_one :order
  has_one :cocktail

end
