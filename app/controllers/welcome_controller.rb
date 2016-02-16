class WelcomeController < ApplicationController
  def index
      @meetings = Meeting.all
      @work_sheets = WorkSheet.all.newest_first.paginate :page => params[:page]
  end
  def edit_meetings
      @meeting = Meeting.find(params[:id])
  end

  def update_meeting
      meeting = Meeting.find(params[:id])
      if meeting.update_attributes(meeting_params)
          flash[:notice] = "预定成功"
          redirect_to :action => 'index'
      else
          flash[:error] = "预定失败"
          redirect_to :action => 'edit_meetings'
      end
  end

  def meeting_params
      params.require(:meeting).permit!
  end

  def empty_meetings
      User.empty_meetings
      redirect_to :action => 'index'
  end

  # layout false
  def test
  end

  def self.newest_first
      order("created_at DESC")
  end
end
