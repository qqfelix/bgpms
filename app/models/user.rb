class User < ActiveRecord::Base
    has_secure_password

    belongs_to :team
    has_many :work_sheets
    has_many :my_projects,:foreign_key => "p_author",:class_name => "Project"
    has_many :week_reports
    has_many :month_reports
    has_many :documents
    has_and_belongs_to_many :projects, join_table: "projects_users"

    def self.newest_first
        order("created_at DESC")
    end

end
