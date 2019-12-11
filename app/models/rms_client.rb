class RmsClient < ApplicationRecord

  validates :name, presence: true, uniqueness: true
  validates :tel, length: { maximum: 13 } 
  validates :email, length: { maximum: 255 } 
  validates :address1, length: { maximum: 255 } 
  validates :address2, length: { maximum: 255 } 
  validates :address3, length: { maximum: 255 } 
  
  # 検索対象のカラム ※デフォルトは全て
  def self.ransackable_attributes(auth_object = nil)
    %w[name]
  end  
end
