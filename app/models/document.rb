class Document < ActiveRecord::Base
    belongs_to :project
    belongs_to :user
    has_attached_file :doc
    do_not_validate_attachment_file_type :doc

    def self.newest_first
        order("created_at DESC")
    end
end
