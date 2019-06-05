class CreateJobApplications < ActiveRecord::Migration
  def change
    create_table :job_applications do |t|
      t.string :resume
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.string :current_company
      t.string :linkedin_url
      t.references :job_posting, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
