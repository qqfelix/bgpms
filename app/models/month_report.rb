class MonthReport < ActiveRecord::Base
    belongs_to :project
    belongs_to :user
    has_many :week_reports

    def self.newest_first
        order("created_at DESC")
    end
end
