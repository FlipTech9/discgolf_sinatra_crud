class Disc < ActiveRecord::Base 
    validates :name, :color, :weight, presence: true
    belongs_to :user 
end 