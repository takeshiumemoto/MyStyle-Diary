class AddTitleAndTimesToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :title, :string
    add_column :events, :start, :datetime
    add_column :events, :end, :datetime
  end
end
