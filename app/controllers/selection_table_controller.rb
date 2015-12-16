class SelectionTableController < ApplicationController
  include WelcomeHelper

  def index
    @tables = Table.all
  end

  def select
    set_current_table_id params[:id]

    Table
        .where(:id => params[:id])
        .update_all(:status => Table.statuses[:occupied])

    redirect_to welcome_index_path
  end
end
