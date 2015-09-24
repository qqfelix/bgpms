class Team < ActiveRecord::Base
    has_many :users
    has_many :work_one_types

    def self.newest_first
        order("created_at DESC")
    end
end
