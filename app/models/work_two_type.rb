class WorkTwoType < ActiveRecord::Base
    belongs_to :work_one_type
    has_many :work_sheets,:foreign_key => 'work_type1'

    def self.newest_first
        order("created_at DESC")
    end
end
