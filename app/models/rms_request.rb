class RmsRequest < ApplicationRecord
  validates :client_id, presence: true
  validates :types,     presence: true
  validates :title,     presence: true, length: { maximum: 255 }   
  validates :yyyy,      presence: true
  validates :mm,        presence: true
  validates :dd,        presence: true
  validates :day_times, presence: true, length: { maximum: 3 }   
    
  validates :yyyy, numericality: { greater_than_or_equal_to: 1989, less_than_or_equal_to: 2099 } , unless: Proc.new { |a| a.yyyy.blank? }
  validates :mm,   numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 12 } , unless: Proc.new { |a| a.mm.blank? } 
  validates :dd,   numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 31 } , unless: Proc.new { |a| a.dd.blank? } 
  
  validates :sales, length: { maximum: 8 }, presence: true 
  validates :expense1, length: { maximum: 8 }, presence: true 
  validates :expense2, length: { maximum: 8 }, presence: true   
  validates :expense3, length: { maximum: 8 }, presence: true 
  validates :expense4, length: { maximum: 8 }, presence: true   
  validates :expense5, length: { maximum: 8 }, presence: true 
  validates :expense6, length: { maximum: 8 }, presence: true   
  validates :expense7, length: { maximum: 8 }, presence: true 
  validates :expense8, length: { maximum: 8 }, presence: true   
  validates :expense9, length: { maximum: 8 }, presence: true 
  validates :expense10, length: { maximum: 8 }, presence: true   
end
