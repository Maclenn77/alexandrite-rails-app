# frozen_string_literal: true

class CreateErrorMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :error_messages do |t|
      t.text :message
      t.string :origin
      t.text :details

      t.timestamps
    end
  end
end
