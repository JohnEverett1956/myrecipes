class Comment < ApplicationRecord
  validates :description, presence: true, length: {minimum: 4 , maximum: 140}
  belongs_to :recipe
  belongs_to :chef
  validates :chef_id, presence: true
  validates :recipe_id, presence: true
  default_scope -> {order(updated_at: :desc)}   
end