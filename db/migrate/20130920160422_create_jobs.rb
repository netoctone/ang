class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :status
      t.string :job_type
      t.string :operator
      t.datetime :status_changed_at
      t.string :destination
      t.integer :pick
      t.string :school

      t.timestamps
    end
  end
end
