class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :search_term
      t.jsonb :search_results, null: false, default: '{}'

      t.timestamps
    end
  end
end
