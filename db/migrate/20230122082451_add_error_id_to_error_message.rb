class AddErrorIdToErrorMessage < ActiveRecord::Migration[7.0]
  def change
    add_column :error_messages, :error_id, :bigint
  end
end
