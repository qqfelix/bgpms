class WorksController < ApplicationController
    def new_sheet
        @teams = Team.all
    end

    def create
      work_sheet = WorkSheet.new(work_sheet_params)
      if work_sheet.save
          flash[:notice] = "工作单创建成功!"
          redirect_to :action => 'new_sheet'
      else
          render 'new_sheet'
      end
    end

    def sheets_unsolved
        @work_sheets = sheets('待处理')
    end

    def sheets_solving
        @work_sheets = sheets('处理中')
    end

    def sheets_solved
        @work_sheets = sheets('已完成')
    end

    def sheet_detail
        @work_sheet = WorkSheet.find(params[:id])
    end

    def sheet_auto
        work_sheet = WorkSheet.find(params[:id])
        week_report = WeekReport.new
        week_report.wr_content = work_sheet.work_description + "\r\n" + work_sheet.work_content
        week_report.project = work_sheet.project
        week_report.user = current_user
        if week_report.save
            flash[:notice] = "创建成功"
        else
            flash[:error] = "创建失败"
        end
        redirect_to :action => 'my_sheets'
    end

    def update
        work_sheet = WorkSheet.find(params[:id])
        if work_sheet.update_attributes(work_sheet_params)
            flash[:notice] = "问题单更新成功"
            redirect_to :action => 'sheet_detail',:id => work_sheet.id
        else
            flash[:error] = "问题单更新失败"
            render 'sheet_detail'
        end
    end

    private
    def work_sheet_params
      params.require(:work_sheet).permit!
    end

    def sheets(type)
        current_user.work_sheets.where("work_status = '#{type}'").newest_first.paginate :page => params[:page]
    end
end
