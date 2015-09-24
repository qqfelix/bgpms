class WorkSheet < ActiveRecord::Base
    belongs_to :user
    belongs_to :project
    belongs_to :work_two_type, :foreign_key => 'work_type1', :class_name => 'WorkTwoType'

    def self.newest_first
        order("created_at DESC")
    end

end
