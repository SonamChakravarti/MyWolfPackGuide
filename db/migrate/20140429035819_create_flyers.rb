class CreateFlyers < ActiveRecord::Migration
  def change
    create_table :flyers do |t|
      t.column :category_id, :integer , :null=> false
      t.column :flyer_name, :string , :null=> false
      t.timestamps
    end
  end

  def self.down
    drop_table :flyers
  end
end
