class RmsMainController < ApplicationController
  def index
   
    # 集計範囲の年を取得する
    sql = " MAX(yyyy) as hi,MIN(yyyy) as lo"
    range = RmsRequest.select(sql)
   
    max = range[0].hi
    min = range[0].lo  
    
    @request_data =[]
    
    if min.present?
      cnt = 0
      for i in min..max
       
        sql = " SELECT " +
              "  yyyy," +      
              "  mm," + 
              "  COUNT(mm) AS cnt ," +             
              "  SUM(sales) AS sales_total," +
              "  SUM(expense1+expense2+expense3+expense4+expense5+expense6+expense7+expense8+expense9+expense10)  AS expense_total" +
              " FROM rms_requests" +        
              " WHERE yyyy = ?" +
              " GROUP BY yyyy,mm" +
              " ORDER BY mm DESC"
        db_data = RmsRequest.find_by_sql([sql,max- cnt]) 
        if db_data.present?     
          @request_data.push(db_data)       
        end  
        cnt += 1        
      end
    end  
    
    respond_to do |format|
      format.html
      format.csv { send_data output_csv, filename: "rms-#{Time.zone.now.strftime('%Y%m%d%H%M%S')}.csv" }
    end
  end
  
  private
  
  
   # CSVの出力
   def output_csv()
    # ヘッダ
    csv = "名前,年,月,日,売上,経費合計,合算,交通費,宿泊費,レンタカー,ガソリン,駐車料金,食事代,衣装代,入場料,その他"
    
    # ご依頼履歴(全て)
    sql = " SELECT name,yyyy,mm,dd,sales,"+
          "   (expense1+expense2+expense3+expense4+expense5+expense6+expense7+expense8+expense9+expense10)  AS expense_total,"+
          "   expense1,expense2,expense3,expense4,expense5,expense6,expense7,expense8,expense9,expense10 "+
          " FROM rms_requests"+ 
          " INNER JOIN rms_clients ON rms_requests.client_id = rms_clients.id"+
          " ORDER BY yyyy DESC, mm DESC,dd DESC"
    csv_data = RmsRequest.find_by_sql(sql)  
    
    # データ
    csv_data.each do |obj|
      csv = csv + "\r\n"
      csv = csv + common_csv_formatting(obj["name"]) + ","
      csv = csv + obj["yyyy"].to_s() + ","
      csv = csv + obj["mm"].to_s() + ","
      csv = csv + obj["dd"].to_s() + ","
      csv = csv + obj["sales"].to_s() + ","
      csv = csv + obj["expense_total"].to_s() + ","
      csv = csv + obj["expense1"].to_s() + ","
      csv = csv + obj["expense2"].to_s() + ","
      csv = csv + obj["expense3"].to_s() + ","
      csv = csv + obj["expense4"].to_s() + ","
      csv = csv + obj["expense5"].to_s() + ","
      csv = csv + obj["expense6"].to_s() + ","
      csv = csv + obj["expense7"].to_s() + ","
      csv = csv + obj["expense8"].to_s() + ","
      csv = csv + obj["expense9"].to_s() + ","
      csv = csv + obj["expense10"].to_s()
    end
    
    csv.encode("Shift_JIS")
   end
end
