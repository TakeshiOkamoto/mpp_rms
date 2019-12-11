class RmsRequestsController < ApplicationController
  before_action :set_rms_request, only: [:show, :edit, :update, :destroy]
  
  before_action :rms_get_clients_combobox, :rms_get_types_combobox
  
  helper_method :common_get_week, :common_convert_nbsp 
  helper_method :rms_get_expense_total, :rms_get_clients_from_id, :rms_get_types_from_id
    
  # GET /requests
  def index
    # SQLで日付を生成してソートする 
    sql = "*, (STR_TO_DATE(yyyy,'%Y') + STR_TO_DATE(mm,'%m')+ STR_TO_DATE(dd,'%d')) as day"
    @q = RmsRequest.select(sql).order(day: "DESC")  
    @rms_requests = @q.page(params[:page]).per(25)  
  end

  # GET /requests/1
  def show
  end

  # GET /requests/new
  def new
    @rms_request = RmsRequest.new
  end

  # GET /requests/1/edit
  def edit
  end

  # POST /requests
  def create
    @rms_request = RmsRequest.new(rms_request_params)

    # 文字列の整形
    rms_request_formatting()    
      
    respond_to do |format|
      if @rms_request.save
        format.html { redirect_to rms_requests_path, notice: '登録しました。' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /requests/1
  def update
    respond_to do |format|
      if @rms_request.update(rms_request_params)
        format.html { redirect_to rms_requests_path, notice: '更新しました。' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /requests/1
  def destroy
    @rms_request.destroy
    respond_to do |format|
      days = @rms_request.yyyy.to_s + "年" + sprintf("%02d月",@rms_request.mm) + sprintf("%02d日",@rms_request.dd) 
      format.html { redirect_to rms_requests_path, alert: '' + days + 'のご依頼を削除しました。' }
    end
  end

  private
    def set_rms_request
      @rms_request = RmsRequest.find(params[:id])
      
      # 文字列の整形
      rms_request_formatting()         
    end

    def rms_request_params
      params.require(:rms_request).permit(:client_id, :title, :types, :yyyy, :mm, :dd, :day_times, :sales, :expense1, :expense2, :expense3, :expense4, :expense5, :expense6, :expense7, :expense8, :expense9, :expense10, :content, :remarks)
    end
    
    # 文字列の整形
    def rms_request_formatting()    
      # 空白除去 ※全角空白を半角空白に変換含む
      @rms_request.title = common_trim(@rms_request.title)  
      @rms_request.content = common_trim(@rms_request.content) 
      @rms_request.remarks = common_trim(@rms_request.remarks) 
    end    
end
