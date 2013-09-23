class CreateFilters < ActiveRecord::Migration
  def change
    create_table :filters do |t|
      t.string :name
      t.text :job_types
      t.string :tags
      t.string :status
      t.text :schools

      t.timestamps
    end
  end
end
