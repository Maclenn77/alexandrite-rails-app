# frozen_string_literal: true

class AddDataSourceToBooks < ActiveRecord::Migration[7.0]
  def change
    add_column :books, :data_source, :string
  end
end
