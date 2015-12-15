class SelectionTableController < ApplicationController
  include WelcomeHelper

  def index
    @tables = Table.all
  end

  def select
    set_current_table_id params[:id]
    redirect_to welcome_index_path
  end
end
