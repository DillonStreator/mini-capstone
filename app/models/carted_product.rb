class CartedProduct < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :product, optional: true
  belongs_to :order, optional: true

  validates :quantity, presence: :true
  validates :quantity, numericality: :true
  validates :quantity, numericality: { greater_than: 0 }
  
end
