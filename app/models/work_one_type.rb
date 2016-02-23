class WorkOneType < ActiveRecord::Base
    has_many :work_two_types, dependent: :destroy
    has_many :work_sheets, through: :work_two_types
    def self.newest_first
        order("created_at ASC")
    end
end
