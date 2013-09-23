class AddTrolleyAndTagsToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :trolley, :string
    add_column :jobs, :tags, :string
  end
end
