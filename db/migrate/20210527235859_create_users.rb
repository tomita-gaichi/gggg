class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :title
      t.date :start_date
      t.date :end_date
      t.boolean :check
      t.string :introduction

      t.timestamps
    end
  end
end
