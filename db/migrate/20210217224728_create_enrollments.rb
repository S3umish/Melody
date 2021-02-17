class CreateEnrollments < ActiveRecord::Migration[6.1]
  def change
    create_table :enrollments do |t|
      t.datetime :startdate
      t.string  :student
      t.string  :level
      t.integer :duration
      t.integer   :price
      t.belongs_to :user
      t.belongs_to :instrument
  

      t.timestamps
    end
  end
end
