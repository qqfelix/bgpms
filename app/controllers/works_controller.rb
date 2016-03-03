class WorksController < ApplicationController

    def month
      #code
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

end
