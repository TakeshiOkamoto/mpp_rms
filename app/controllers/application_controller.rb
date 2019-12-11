class ApplicationController < ActionController::Base

# このプロジェクト固有のメソッド名には先頭に"rms_"が付与されています。

  helper_method :current_user
  before_action :login?
   
# -----------------------------
#  ログイン系
# -----------------------------
  # ログイン済みならばユーザー情報を取得する
  def current_user
    @current_user ||= RmsUser.find_by(id: session[:user_id]) if session[:user_id]
  end
  
  def login?
    if current_user.blank?
      redirect_to login_path
    end  
  end
    
# -----------------------------
#  メソッド
# -----------------------------
  # 空白除去 ※全角空白を半角空白に変換含む
  def common_trim(str)
    str.gsub("　"," ").strip  
  end
  
  # CSVの書式設定  
  def common_csv_formatting(str)
    if (str.include?(',') || str.include?('"'))
      if str.include?('"')
        str = str.gsub('"','""')
      end
      return '"' + str + '"'
    end
    return str
  end
      
  # コンボボックス用 - 顧客
  def rms_get_clients_combobox()
    clients = RmsClient.all.order(name: "ASC")
    @rms_clients_list = []
    clients.each { |obj| 
      @rms_clients_list.push([obj['name'],obj['id']])
    }
  end
  
  # コンボボックス用 - 種類
  def rms_get_types_combobox()
    @rms_types_list = []
    @rms_types_list.push(['出張',1])
    @rms_types_list.push(['電話相談',2])
    @rms_types_list.push(['調査/調整',3])
    @rms_types_list.push(['仲間に紹介',4])
  end  
    
# -----------------------------
#  ヘルパーメソッド
# -----------------------------
  COMMON_WEEK = ["日","月","火","水","木","金","土"]
  
  # 曜日を取得する  
  def common_get_week(yyyy,mm,dd)    
    tm =  Time.zone.parse(yyyy.to_s + '/' + mm.to_s + '/' + dd.to_s)    
    COMMON_WEEK[tm.wday]    
  end
  
  # 空白(スペース)とタブを&nbsp;に変換
  # ※<a href=""></a>の「a 」の空白は変換しないようにする 
  def common_convert_nbsp(str)
    result = ""
    preflg = false
    
    str.chars { |s|
      
      # 空白
      if (s == " ") && (!preflg)
        result += "&nbsp;"
      # タブ  
      elsif (s == "	") 
        result += "&nbsp;&nbsp;"
      else
        result += s
      end   
     
      if s == "a"
        preflg = true
      else
        preflg = false
      end 
   }
   result  
  end        
  
  # 経費の合算  
  def rms_get_expense_total(obj)    
     obj.expense1 + obj.expense2 + obj.expense3 + 
     obj.expense4 + obj.expense5 + obj.expense6 + 
     obj.expense7 + obj.expense8 + obj.expense9 + 
     obj.expense10
  end  
  
  # idから顧客名を取得する 
  def rms_get_clients_from_id(id)
     @rms_clients_list.each_with_index do |obj,i|
       if(obj[1] == id)
         return obj[0]
       end  
     end
     return "";
  end  
    
  # idから種類名を取得する 
  def rms_get_types_from_id(id)
     @rms_types_list.each_with_index do |obj,i|
       if(obj[1] == id)
         return obj[0]
       end  
     end
     return "";
  end   
  
  # idからご依頼の統計情報を取得する
  def rms_get_requests_total_data(id)
    @rms_requests_total_data.each { |obj| 
      if obj.client_id == id    
        return obj
      end  
    }
    
    # NULL用
    obj ={}
    obj["cnt"] = obj["sales_total"] = obj["expense_total"] =  0 
    obj["lastday"] = ""
    return obj
  end     
end
