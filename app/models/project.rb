class Project < ActiveRecord::Base
    has_many :work_sheets
    has_many :week_reports
    has_many :month_reports
    has_many :documents
    has_and_belongs_to_many :users, join_table: "projects_users"
    belongs_to :user, :foreign_key => "p_author",:class_name => "User"
    belongs_to :team

    def self.newest_first
        order("created_at DESC")
    end
end
