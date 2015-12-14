class SelectionTableController < ApplicationController

  def index
    @tables = Table.all
  end

end
