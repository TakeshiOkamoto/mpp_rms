class RmsClientsController < ApplicationController
  before_action :set_rms_client, only: [:show, :edit, :update, :destroy]

  helper_method :common_get_week, :common_convert_nbsp
  helper_method :rms_get_expense_total, :rms_get_types_from_id, :rms_get_requests_total_data  

  # GET /clients
  def index
    @q = RmsClient.order(name: "ASC")
    
    # 空白除去 ※全角空白を半角空白に変換含む
    if params[:q].present?
      params[:q][:name_cont]= common_trim(params[:q][:name_cont])
    end  
    
    @q = @q.ransack(params[:q])  
    @rms_clients = @q.result(distinct: true).page(params[:page]).per(25)  
    
    # ID/総売上/総経費/ご依頼件数/最終ご依頼日
    sql = " SELECT "+
          "   client_id, " +
          "   SUM(sales) AS sales_total," +
          "   SUM(expense1+expense2+expense3+expense4+expense5+expense6+expense7+expense8+expense9+expense10) AS expense_total," +
          "   COUNT(client_id) AS cnt," +
          "   MAX(STR_TO_DATE(yyyy,'%Y') + STR_TO_DATE(mm,'%m')+ STR_TO_DATE(dd,'%d')) AS lastday" +
          " FROM rms_requests" +
          " GROUP BY client_id" 
    @rms_requests_total_data = RmsRequest.find_by_sql(sql)  
  end

  # GET /clients/1
  def show
     # コンボボックスデータ
     rms_get_types_combobox()
     
     # SQLで日付を生成してソートする - 過去の履歴用
     sql = "SELECT *, (STR_TO_DATE(yyyy,'%Y') + STR_TO_DATE(mm,'%m')+ STR_TO_DATE(dd,'%d')) as day" +
           " FROM rms_requests" +
           " WHERE client_id =?" +
           " ORDER BY day DESC"           
     @rms_requests = RmsRequest.find_by_sql([sql,params[:id]])      
  end

  # GET /clients/new
  def new
    @rms_client = RmsClient.new
  end

  # GET /clients/1/edit
  def edit
  end

  # POST /clients
  def create
    @rms_client = RmsClient.new(rms_client_params) 

    # 文字列の整形
    rms_client_formatting()
     
    respond_to do |format|
      if @rms_client.save
        format.html { redirect_to rms_clients_path, notice: '登録しました。' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /clients/1
  def update      
    respond_to do |format|
      if @rms_client.update(rms_client_params)
        format.html { redirect_to rms_clients_path, notice: '更新しました。' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /clients/1
  def destroy
    
    # 顧客に紐づくご依頼も削除する
    ActiveRecord::Base.transaction do
       @rms_client.destroy!
       requests = RmsRequest.where(client_id: @rms_client.id)       
       requests.each { |a|
         a.destroy! 
       } 
       redirect_to rms_clients_path, alert: "「#{@rms_client.name}」さんを削除しました。"
    end
  end

  
  private
    def set_rms_client
      @rms_client = RmsClient.find(params[:id])
      
      # 文字列の整形
      rms_client_formatting()                                             
    end

    def rms_client_params
      params.require(:rms_client).permit(:name, :tel, :email, :address1, :address2, :address3, :info)
    end    
  
    # 文字列の整形
    def rms_client_formatting()    
      # 空白除去 ※全角空白を半角空白に変換含む
      @rms_client.name = common_trim(@rms_client.name)  
      @rms_client.tel = common_trim(@rms_client.tel) 
      @rms_client.email = common_trim(@rms_client.email) 
      @rms_client.address1 = common_trim(@rms_client.address1) 
      @rms_client.address2 = common_trim(@rms_client.address2) 
      @rms_client.address3 = common_trim(@rms_client.address3) 
      @rms_client.info = common_trim(@rms_client.info)  
    end    
end
