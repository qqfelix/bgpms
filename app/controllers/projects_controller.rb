class ProjectsController < ApplicationController
  def index
    @projects = current_user.my_projects.newest_first.paginate(:page => params[:page])
  end

  def project_new
    @project = Project.new
  end

  def project_create
    project = Project.new(project_params)
    project.team = current_user.team
    project.p_no = "#{pinyin(current_user.team.name)}-#{pinyin(project.p_status)}-#{DateTime.now.year}-#{add_zero(current_user.team.projects.size+1,4)}"
    if project.save
        flash[:notice] = "项目创建成功"
        redirect_to :action => 'index'
    else
        flash[:error] = "项目创建失败"
        render 'project_new'
    end
  end

  def project_edit
      @project = Project.find(params[:id])
  end

  def project_update
    project = Project.find(params[:id])
    if project.update_attributes(project_params)
        flash[:notice] = "项目修改成功"
        redirect_to :action => 'index'
    else
        flash[:error] = "项目修改失败"
        render 'project_edit'
    end
  end

  def documents
    @document = Document.new
    @documents = current_user.documents.newest_first.paginate(:page => params[:page])
  end

  def document_create
      document = Document.new(doc_params)
      document.user = current_user
      if document.save
          flash[:notice] = "创建成功"
      else
          flash[:error] = "创建失败"
      end
      redirect_to :action => 'documents'
  end

  def week
      @week_report = WeekReport.new
      @week_reports = current_user.week_reports.newest_first.paginate(:page => params[:page])
  end

  def week_create
      wr = WeekReport.new(week_params)
      wr.user = current_user
      if wr.save
          flash[:notice] = "创建成功"
          redirect_to :action => 'week'
      else
          flash[:error] = "创建失败"
          render 'week'
      end
  end

  def week_destroy
      wr = WeekReport.find(params[:id])
      wr.destroy
      flash[:notice] = "删除成功"
      redirect_to :action => 'week'
  end

  def month
      @month_report = MonthReport.new
      @month_reports = current_user.month_reports.newest_first.paginate(:page => params[:page])
  end

  def month_create
      mr = MonthReport.new(month_params)
      mr.user = current_user
      if mr.save
          flash[:notice] = "创建成功"
          redirect_to :action => 'month'
      else
          flash[:error] = "创建失败"
          render 'month'
      end
  end

  def month_destroy
      mr = MonthReport.find(params[:id])
      mr.destroy
      flash[:notice] = "删除成功"
      redirect_to :action => 'month'
  end


  private
  def project_params
      params.require(:project).permit!
  end
  def week_params
      params.require(:week_report).permit!
  end
  def month_params
      params.require(:month_report).permit!
  end
  def doc_params
      params.require(:document).permit!
  end

  def pinyin(str)
      Pinyin.t(str) {|letters| letters[0].upcase} if str
  end

  def add_zero(str,length)
      "0"*(length-str.to_s.size) + str.to_s
  end
end
