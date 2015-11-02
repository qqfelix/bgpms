class WorkOneType < ActiveRecord::Base
    has_many :work_two_types, dependent: :destroy

    def self.newest_first
        order("created_at ASC")
    end
end
