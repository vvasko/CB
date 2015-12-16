class SelectionTableController < ApplicationController
  include WelcomeHelper

  def index
    @tables = Table.all
    @current_table = get_current_table_id
    if @current_table.present?
      Table.set_status @current_table, Table.statuses[:free]
    end
  end

  def select
    set_current_table_id params[:id]

    Table.set_status params[:id], Table.statuses[:occupied]

    redirect_to welcome_index_path
  end
end
