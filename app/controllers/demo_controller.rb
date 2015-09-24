class DemoController < ApplicationController
  def index
      @work_sheets = current_user.work_sheets.newest_first.paginate :page => params[:page],:per_page => 2
      respond_to do |format|
          format.html
         format.js   {}
      end
  end
  def index2
    #code
  end
end
