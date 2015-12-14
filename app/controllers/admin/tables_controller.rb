class Admin::TablesController < ApplicationController

  def index
    @tables = Table.all
  end

end
