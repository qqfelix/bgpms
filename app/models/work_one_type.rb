class WorkOneType < ActiveRecord::Base
    belongs_to :team
    has_many :work_two_types, dependent: :destroy

    def self.newest_first
        order("created_at DESC")
    end
end
