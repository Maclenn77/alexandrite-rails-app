class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.bigint 'book_id', null: false
      t.string 'title', null: false
      t.string 'authors', array: true, default: []
      t.string 'publisher'
      t.text 'description'
      t.string 'language'
      t.string 'country'
      t.bigint 'isbn10'
      t.bigint 'isbn13'
      t.string 'ddc'
      t.string 'lcc'
      t.string 'categories', array: true, default: []
      t.integer 'page_count'
      t.date 'published_date'
      t.string 'suggested_classifications', array: true, default: []
      t.string 'error_message'

      t.timestamps
    end
  end
end
