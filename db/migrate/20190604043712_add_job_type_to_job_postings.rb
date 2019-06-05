class AddJobTypeToJobPostings < ActiveRecord::Migration
  def change
    add_column :job_postings, :job_type, :string
    add_column :job_postings, :city, :string
  end
end
