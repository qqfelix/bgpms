class User < ActiveRecord::Base
    has_secure_password

    belongs_to :team
    has_many :work_sheets
    has_many :my_projects,:foreign_key => "p_author",:class_name => "Project"
    has_many :week_reports
    has_many :month_reports
    has_many :documents
    has_and_belongs_to_many :projects, join_table: "projects_users"

    def self.newest_first
        order("created_at DESC")
    end

    def self.empty_meetings
        rooms = ["604大会议","604小会议","7楼会议室"]
        Meeting.delete_all
        puts "Meeting.delete_all"
        rooms.each do |room|
          m = Meeting.new
          m.name = room
          m.save
        end
    end

    before_create { generate_token(:auth_token) }

    def generate_token(column)
      begin
        self[column] = SecureRandom.urlsafe_base64
      end while User.exists?(column => self[column])
    end

end
