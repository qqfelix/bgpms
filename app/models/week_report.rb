class WeekReport < ActiveRecord::Base
    belongs_to :project
    belongs_to :user
    belongs_to :month_report

    def self.newest_first
        order("created_at DESC")
    end
end
