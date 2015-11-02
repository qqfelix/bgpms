class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?, :sheets_unsolved

  WillPaginate.per_page = 10



  def is_logged
    if !logged_in?
        redirect_to :controller => 'users', :action => 'signin'
    end
  end

  def Pinyin(name)
      Pinyin.t(name) { |letters| letters[0].upcase }
  end






  private

      def current_user
        @current_user ||= User.find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token]
      end

      def sheets_unsolved
        current_user.work_sheets.where("work_status = '待处理'").newest_first
      end



      def method
        #code
      end

      def logged_in?
          current_user != nil
      end


end
