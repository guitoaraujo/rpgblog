class AddRulebookToArticles < ActiveRecord::Migration[6.1]
  def change
    add_reference :articles, :rulebook, null: false, foreign_key: true
  end
end
