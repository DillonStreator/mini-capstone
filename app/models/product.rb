class Product < ApplicationRecord
  belongs_to :supplier
  has_many :orders
  has_many :images
  has_many :category_products
  has_many :categories, through: :category_products
  has_many :carted_products
  has_many :orders, through: :carted_products

  def sale_message
    if price <= 2
      return "Discount item!!!"
    else
      return "Everyday value!"
    end
  end

  def tax
    return (price * 0.09).round(2)
  end

  def total
    return (price + tax).round(2)
  end

  def discount?
    return price <= 3
  end

  def self.search(name)
    products = Product.where("name LIKE ?", ("%#{name}%"))
    return products
  end

#added this code to HTML in order to get <a> tags around category names.
  def list_categories
    friendly_categories = []
    self.categories.each do |category|
      if category == categories[(categories.size - 2)]
        friendly_categories << "#{category.name} and "
      elsif category == categories[(categories.size - 1)]
        friendly_categories << "#{category.name}"
      else
        friendly_categories << "#{category.name}, "
      end
    end
    friendly_categories.join('')
  end
end
