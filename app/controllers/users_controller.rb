class UsersController < ApplicationController
  skip_before_action :is_logged

# 注册、登录、退出部分
  def signup
      @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
        flash[:notice] = "用户注册更新成功！"
        cookies[:auth_token] = user.auth_token
        redirect_to :root
    else
        render 'signup'
    end


  end



  def signin
      @user = User.new
  end

  def login
    user = User.find_by_name(params[:user][:name])
    if user && user.authenticate(params[:user][:password])
        # session[:user_id] = user.id
        if params[:remember_me]
           cookies.permanent[:auth_token] = user.auth_token
        else
           cookies[:auth_token] = user.auth_token
        end

        # client = Mongo::Client.new('mongodb://10.1.2.194:27017/pms')
        # client[:users].insert_one({:auth_token => user.auth_token,:msg=>'',})
        # 登陆的时候判断mongodb，如果没有则新增，如果有则不做任何操作

        client = Mongo::Client.new('mongodb://10.1.2.194:27017/pms')
        if client[:users].find(:auth_token => "#{user.auth_token}").count == 0
            client[:users].insert_one({ auth_token: "#{user.auth_token}",msg:"",name:"#{user.name}" })
        end


        flash[:notice] = "登录成功！"
        redirect_to :controller => 'sheets', :action => 'new_sheet'
    else
        flash[:error] = "用户名或密码错误！"
        render 'signin'
    end
  end

  def logout
    # session[:user_id] = nil
    cookies.delete(:auth_token)
    flash[:notice] = "退出成功！"
    redirect_to :root
  end

#用户管理

#欢迎

  def welcome

  end

#基本资料
  def edit
    @user =current_user
  end

  def update
      @user = current_user

      if @user.update_attributes(user_params)
          flash[:notice] = "用户资料更新成功！"
          redirect_to :action => 'edit'
      else
          render 'edit'
      end
  end

#所属组
  def team_show
    @teams = Team.all
    if current_user && current_user.team
        @team_id = current_user.team.id
    else
        @team_id = 0
    end
  end

  def team_update
    team = Team.find(params[:team_id])
    current_user.team = team
    if current_user.save
        flash[:notice] = "#{team.name}组更新成功!"
        redirect_to :action => 'team_show'
    else
        flash[:error] = "操作错误!"
        render 'team_show'
    end
  end

# 数据字典维护

  def work_sheet_dictionaries
    @wots = WorkOneType.newest_first.paginate(:page => params[:page])
  end

  def one_new
    @wot = WorkOneType.new
  end

  def one_create
      wot = WorkOneType.new(one_params)
      if wot.save
          flash[:notice] = "创建成功"
          redirect_to :action => 'work_sheet_dictionaries'
      end
  end

  def one_update
      wot = WorkOneType.find(params[:id])
      if wot.update_attributes(one_params)
          flash[:notice] = "修改成功"
          redirect_to :action => 'work_sheet_dictionaries'
      end
  end

  def one_destroy
    wot = WorkOneType.find(params[:id])
    wot.destroy
    flash[:notice] = "删除成功"
    redirect_to :action => 'work_sheet_dictionaries'
  end

  def dictionaries_work_one_type
    @wot = WorkOneType.find(params[:id])
    @wtts = @wot.work_two_types.newest_first.paginate(:page => params[:page])
  end

  def two_create
    wot = WorkOneType.find(params[:id])
    wtt = WorkTwoType.new(two_params)
    wtt.work_one_type = wot
    if wtt.save
        flash[:notice] = "创建成功"
        redirect_to :action => 'dictionaries_work_one_type', :id => wot.id
    else
        render 'dictionaries_work_one_type'
    end
  end

  def two_update
      wtt = WorkTwoType.find(params[:id])
      if wtt.update_attributes(two_params)
          flash[:notice] = "修改成功"
          redirect_to :action => 'dictionaries_work_one_type', :id => wtt.work_one_type.id
      end
  end

  def two_destroy
    wtt = WorkTwoType.find(params[:id])
    wtt.destroy
    flash[:notice] = "删除成功"
    redirect_to :action => 'dictionaries_work_one_type',:id => wtt.work_one_type.id
  end


  #项目类别字典
  #project_dictionaries
  def project_dictionaries
    @dict = Dict.new
    @dicts = Dict.all.order("dict_key")
  end

  def dict_create
      dict = Dict.new(dict_params)
      if dict.save
          flash[:notice] = "创建成功"
          respond_to do |format|
            format.html {
                redirect_to :action => 'project_dictionaries'
            }
          end
      else
          flash[:notice] = '创建失败'
          render 'project_dictionaries'
      end
  end

  def dict_destroy
    dict = Dict.find(params[:id])
    dict.destroy
    flash[:notice] = "删除成功"
    redirect_to :action => 'project_dictionaries'
  end




  private
  def user_params
    params.require(:user).permit!
  end

  def one_params
      params.require(:wot).permit!
  end

  def two_params
      params.require(:wtt).permit!
  end

  def dict_params
    params.require(:dict).permit!
  end
end
