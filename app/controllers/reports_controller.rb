class ReportsController < ApplicationController


  def team
      @teams = {}
      Team.all.each do |team|
        @teams["#{team.name}"] = [0,0,0,0]
      end

      WorkSheet.all.each do |ws|
        team = @teams["#{ws.user.team.name}"]
        if ws.work_status == "待处理"
            team[0] += 1
        elsif ws.work_status == "处理中"
            team[1] += 1
        elsif ws.work_status == "已完成"
            team[2] += 1
        end
        team[3] += 1
      end
  end

  def type
  end

  def files

  end

  def files_download

      p_begin_date = "#{params['date']['p_begin_date(1i)']}-#{params['date']['p_begin_date(2i)']}-#{params['date']['p_begin_date(3i)']}".to_datetime
      p_end_date = "#{params['date']['p_end_date(1i)']}-#{params['date']['p_end_date(2i)']}-#{params['date']['p_end_date(3i)']}".to_datetime

      download(params[:type],p_begin_date,p_end_date,params['all'])

  end

  def download(type,p_begin_date,p_end_date,all)
    if type == "问题单下载"
        worksheets_download(p_begin_date,p_end_date,all)
    elsif type == "问题分析下载"
        worksheets_fenxi_download(p_begin_date,p_end_date)
    elsif type == "周报下载"
        week_download(p_begin_date,p_end_date)
    elsif type == "月报下载"
        month_download(p_begin_date,p_end_date)
    end
  end

  def worksheets_download(p_begin_date,p_end_date,all)
    begin_date = p_begin_date
    end_date   = p_end_date

    if all == "个人"
        @work_sheets = current_user.work_sheets
    else
        @work_sheets = WorkSheet.where("created_at between '#{begin_date}' and '#{end_date}'")
    end

    file_contents = StringIO.new
    book = Spreadsheet::Workbook.new
    sheet = book.create_worksheet
    sheet.name = "问题单"
    sheet.row(0).push "领域","项目负责人","问题处理人","处理状态","问题类型","问题级别","序号",
    "问题描述","问题频率","提出部门","问题分析及处理意见","修改程序个数","计划完成日期","实际完成日期","问题受理人"

    # sheet.row(0).push "受理时间","受理人","工作类别","主类别","子类别","发生地点","报修人",
    # "保修电话","现象描述","用户需求","开始时间","结束时间","处理人","处理内容","处理状态"
    header_format = Spreadsheet::Format.new :color => :blue,
                                 :weight => :bold,
                                 :size => 16
    sheet.row(0).default_format = header_format
    content_format = Spreadsheet::Format.new :size => 14,:text_wrap => true,:horizontal_align => :left,
                                     :vertical_align => :top
    (0..14).each do |i|
      sheet.column(i).width = 14
    end
    @work_sheets.each_with_index do |work_sheet, index|
        sheet.row(index+1).push work_sheet.work_two_type.work_one_type.name,
                                work_sheet.work_leader,
                                work_sheet.user.name,
                                work_sheet.work_status2,
                                work_sheet.work_mode,
                                work_sheet.work_type,
                                work_sheet.classify_code,
                                work_sheet.work_description,
                                work_sheet.work_rate,
                                work_sheet.work_place,
                                work_sheet.work_content,
                                work_sheet.program_nums,
                                work_sheet.work_benin_datetime ? work_sheet.work_benin_datetime.strftime("%y-%m-%d") : "",
                                work_sheet.work_end_datetime ? work_sheet.work_end_datetime.strftime("%y-%m-%d") : "",
                                work_sheet.username
        # sheet.row(index+1).push work_sheet.work_datetime.strftime("%y-%m-%d"),
        #                         work_sheet.username,
        #                         work_sheet.work_type,
        #                         work_sheet.work_two_type ? work_sheet.work_two_type.work_one_type.name : "",
        #                         work_sheet.work_two_type ? work_sheet.work_two_type.name : "",
        #                         work_sheet.work_place,
        #                         work_sheet.work_person,
        #                         work_sheet.work_person_phone,
        #                         work_sheet.work_description,
        #                         work_sheet.work_demand,
        #                         work_sheet.work_benin_datetime ? work_sheet.work_benin_datetime.strftime("%y-%m-%d") : "",
        #                         work_sheet.work_end_datetime ? work_sheet.work_end_datetime.strftime("%y-%m-%d") : "",
        #                         work_sheet.user.name,
        #                         work_sheet.work_content,
        #                         work_sheet.work_status

        # sheet.row(index+1).default_format = content_format
    end

    file_name = "sheet#{begin_date.strftime('%y%m%d')}-#{end_date.strftime('%y%m%d')}.xls"
    user_agent = request.user_agent.downcase
    escaped_file_name = user_agent.include?("msie") ? CGI::escape(file_name) : file_name

    book.write file_contents
    send_data file_contents.string.force_encoding('binary'),:type=>"application/xls;charset=utf-8", filename: escaped_file_name

  end

  def worksheets_fenxi_download(p_begin_date,p_end_date)
    begin_date = p_begin_date
    end_date   = p_end_date


    file_contents = StringIO.new
    book = Spreadsheet::Workbook.new
    sheet = book.create_worksheet
    sheet.name = "问题分析下载"
    sheet.merge_cells(0,0,1,0);
    sheet.merge_cells(0,1,1,1);
    sheet.merge_cells(0,2,0,6);
    sheet.merge_cells(0,7,0,14);
    sheet.merge_cells(0,26,0,28);
    sheet.row(1).push "领域","问题总数","A已结案","B已完成","C处理中","D方案研讨中","E已反馈",
    "A1数据下载","A2请示报告","A3问题协调","A4业务授权","A5业务咨询","A6修改数据","A7删除数据",
    "A8导入数据","B系统问题","C系统优化","D需求新增","E操作问题","F接口修改","G处内协调","H报表新增",
    "I电源","J设备故障","K网络","J其它","A紧急","B重要","C普通"
    sheet.row(0).insert 0,'领域'
    sheet.row(0).insert 1,'问题总数'
    sheet.row(0).insert 2,'完成情况'
    sheet.row(0).insert 7,'业务问题'
    sheet.row(0).insert 26,'业务问题'

    header_format = Spreadsheet::Format.new :color => :blue,
                                 :weight => :bold,
                                 :size => 16,:text_wrap => true,:horizontal_align => :center,:vertical_align => :middle
    content_format = Spreadsheet::Format.new :size => 14,:text_wrap => true,:horizontal_align => :center,
                                     :vertical_align => :top
    sheet.row(0).default_format = header_format
    sheet.row(1).default_format = header_format
    (0..29).each do |i|
      sheet.column(i).width = 7
    end
    WorkOneType.all.each_with_index do |type,index|
        ws = type.work_sheets.where("work_sheets.created_at between '#{begin_date}' and '#{end_date}'")
        sheet.row(index+2).push type.name,
                                ws.count, ws.where(:work_status2 => 'A已结案').count,
                                ws.where(:work_status2 => 'B已完成').count,
                                ws.where(:work_status2 => 'C处理中').count,
                                ws.where(:work_status2 => 'D方案研讨中').count,
                                ws.where(:work_status2 => 'E已反馈').count,
                                ws.where(:work_mode => 'A1数据下载').count,
                                ws.where(:work_mode => 'A2请示报告').count,
                                ws.where(:work_mode => 'A3问题协调').count,
                                ws.where(:work_mode => 'A4业务授权').count,
                                ws.where(:work_mode => 'A5业务咨询').count,
                                ws.where(:work_mode => 'A6修改数据').count,
                                ws.where(:work_mode => 'A7删除数据').count,
                                ws.where(:work_mode => 'A8导入数据').count,
                                ws.where(:work_mode => 'B系统问题').count,
                                ws.where(:work_mode => 'C系统优化').count,
                                ws.where(:work_mode => 'D需求新增').count,
                                ws.where(:work_mode => 'E操作问题').count,
                                ws.where(:work_mode => 'F接口修改').count,
                                ws.where(:work_mode => 'G处内协调').count,
                                ws.where(:work_mode => 'H报表新增').count,
                                ws.where(:work_mode => 'I电源').count,
                                ws.where(:work_mode => 'J设备故障').count,
                                ws.where(:work_mode => 'K网络').count,
                                ws.where(:work_mode => 'Z其它').count,
                                ws.where(:work_rate => 'A频繁').count,
                                ws.where(:work_rate => 'B经常').count,
                                ws.where(:work_rate => 'C很少').count

    end
    # @work_sheets.each_with_index do |work_sheet, index|
    #     sheet.row(index+1).push work_sheet.work_two_type.work_one_type.name,
    #                             work_sheet.work_leader,
    #                             work_sheet.username,
    #                             work_sheet.work_status2,
    #                             work_sheet.work_mode,
    #                             work_sheet.work_type,
    #                             work_sheet.classify_code,
    #                             work_sheet.work_description,
    #                             work_sheet.work_rate,
    #                             work_sheet.work_place,
    #                             work_sheet.work_content,
    #                             work_sheet.program_nums,
    #                             work_sheet.work_benin_datetime ? work_sheet.work_benin_datetime.strftime("%y-%m-%d") : "",
    #                             work_sheet.work_end_datetime ? work_sheet.work_end_datetime.strftime("%y-%m-%d") : "",
    #                   work_sheet.work_status
    #     sheet.row(index+1).default_format = content_format
    # end

    file_name = "sheet#{begin_date.strftime('%y%m%d')}-#{end_date.strftime('%y%m%d')}.xls"
    user_agent = request.user_agent.downcase
    escaped_file_name = user_agent.include?("msie") ? CGI::escape(file_name) : file_name

    book.write file_contents
    send_data file_contents.string.force_encoding('binary'),:type=>"application/xls;charset=utf-8", filename: escaped_file_name

  end

  def week_download(p_begin_date,p_end_date)

      begin_date = p_begin_date
      end_date   = p_end_date

      projects = Project.all
      file_contents = StringIO.new
      book = Spreadsheet::Workbook.new
      sheet = book.create_worksheet
      sheet.name = "周报"
      sheet.row(0).push '项目类别','项目状态','领域分级','项目名称','负责人','开发方','管理部门',
                        '计划开始日期','计划上线日期','小组成员','本周工作','下周计划'
      header_format = Spreadsheet::Format.new :color => :blue,
                                   :weight => :bold,
                                   :size => 16
      sheet.row(0).default_format = header_format
      center_format = Spreadsheet::Format.new :size => 14,:text_wrap => true,:horizontal_align => :center,
                                       :vertical_align => :middle
      content_format = Spreadsheet::Format.new :size => 14,:text_wrap => true,:horizontal_align => :left,
                                       :vertical_align => :top
      (0..11).each do |i|
        sheet.column(i).width = 16
      end

      index = 0
      projects.each_with_index do |p,i|
          users_size = p.users.count == 0 ?  1 : p.users.count
          sheet.row(i+1).push p.p_no, p.p_status, p.p_level, p.p_name, p.user.name, p.p_owner,
                              p.p_dept, p.p_begin_date.strftime("%y-%m-%d"), p.p_end_date.strftime("%y-%m-%d")
          sheet.row(i+1).default_format = center_format

          p.users.each_with_index do |u,j|
              sheet.row(i + j + 1).insert 9,u.name
              c1=c2= ""
              week_reports = u.week_reports.where("created_at between '#{begin_date}' and '#{end_date}'")
              week_reports.each_with_index do |wr, order|
                  if wr
                      c1 = c1 + "#{order+1}. #{wr.wr_content.to_s}(#{wr.created_at.strftime("%y-%m-%d")})" + "\r\n" if wr.wr_content
                      c2 = c2 + "#{order+1}. #{wr.wr_plan.to_s}(#{wr.created_at.strftime("%y-%m-%d")})" + "\r\n" if wr.wr_plan
                  end
              end
              sheet.row(i + j + 1).insert 10,c1
              sheet.row(i + j + 1).set_format 10,content_format
              sheet.row(i + j + 1).insert 11,c2
              sheet.row(i + j + 1).set_format 11,content_format

          end

          (0..8).each do |k|
              sheet.merge_cells(index+1,k,index + users_size,k)
          end

          index = index + users_size
      end



      file_name = "week#{p_begin_date.strftime('%y%m%d')}-#{p_end_date.strftime('%y%m%d')}.xls"
      user_agent = request.user_agent.downcase
      escaped_file_name = user_agent.include?("msie") ? CGI::escape(file_name) : file_name

      book.write file_contents
      send_data file_contents.string.force_encoding('binary'),:type=>"application/xls;charset=utf-8", filename: escaped_file_name

  end

  def month_download(p_begin_date,p_end_date)

      begin_date = p_begin_date
      end_date   = p_end_date

      projects = Project.all
      file_contents = StringIO.new
      book = Spreadsheet::Workbook.new
      sheet = book.create_worksheet
      sheet.name = "月报"
      headers = ["项目名称","项目负责人","系统开发方","管理部门","开始日期","项目结束日期","已存文档"]
      sheet.row(0).replace headers

      center_format = Spreadsheet::Format.new :size => 14,:text_wrap => true,:horizontal_align => :center,
                                       :vertical_align => :middle
      content_format = Spreadsheet::Format.new :size => 14,:text_wrap => true,:horizontal_align => :left,
                                       :vertical_align => :top

      sheet.row(0).default_format = center_format
      sheet.row(1).default_format = center_format
      (0..headers.size-1).each do |i|
          sheet.merge_cells(0,i,1,i)
          sheet.column(i).width = 16
      end

      index_col = headers.size
      while "#{begin_date.year}-#{begin_date.month}" != "#{end_date.year}-#{end_date.month}"
          puts "#{begin_date.year}年#{begin_date.month}月主要工作"
          sheet.row(0).insert index_col, "#{begin_date.year}年#{begin_date.month}月主要工作"
          sheet.row(1).insert index_col, "完成工作","工作计划","存在问题及解决情况"
          (0..2).each do |i|
            sheet.column(index_col+i).width = 30
          end
          sheet.merge_cells(0,index_col,0,index_col+2)
          index_col += 3
          begin_date = begin_date.next_month
      end

      begin_date = p_begin_date
      end_date   = p_end_date

      projects.each_with_index do |p,i|

          documents = "共计#{p.documents.size}个文档" + "\r\n"
          p.documents.each_with_index do |document,index|
              documents += "#{index+1}. #{document.name}" + "\r\n"
          end

          sheet.row(i+2).push p.p_name, p.user.name, p.p_owner, p.p_dept,
                              p.p_begin_date.strftime("%y-%m-%d"), p.p_end_date.strftime("%y-%m-%d"),
                              documents
          sheet.row(i+2).default_format = content_format
          (0..headers.size-1).each do |index|
              sheet.row(i+2).set_format(index,center_format)
          end

          index_col = headers.size

          while "#{begin_date.year}-#{begin_date.month}" != "#{end_date.year}-#{end_date.month}"
              mr_content =  ""
              mr_plan = ""
              p.users.each do |user|
                mr_content += "#{user.name}本月工作内容:" + "\r\n"
                mr_plan  += "#{user.name}下月工作计划:" + "\r\n"
                user.month_reports.where("created_at between '#{begin_date}' and '#{begin_date.next_month}'").each do |mr|
                    mr_content += mr.mr_content + "\r\n"
                    mr_plan += mr.mr_plan + "\r\n"
                end
              end
              sheet.row(i+2).push mr_content, mr_plan, "无"
              begin_date = begin_date.next_month
          end

      end

      file_name = "month#{p_begin_date.strftime('%y%m%d')}-#{p_end_date.strftime('%y%m%d')}.xls"
      user_agent = request.user_agent.downcase
      escaped_file_name = user_agent.include?("msie") ? CGI::escape(file_name) : file_name

      book.write file_contents
      send_data file_contents.string.force_encoding('binary'),:type=>"application/xls;charset=utf-8", filename: escaped_file_name

  end

end
