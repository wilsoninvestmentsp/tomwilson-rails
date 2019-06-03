class CreateJobPostings < ActiveRecord::Migration
  def change
    create_table :job_postings do |t|
      t.string :name
      t.text :description
      t.integer :job_status

      t.timestamps null: false
    end
  end
end
