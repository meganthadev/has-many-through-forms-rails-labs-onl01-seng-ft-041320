class Post < ActiveRecord::Base
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :comments
  has_many :users, through: :comments

  def categories_attributes=(categories_attributes)
    categories_attributes.values.each do |cat_attr|
      if cat_attr[:name].present?
        category = Category.find_or_create_by(cat_attr)
        if !self.categories.include?(category)
          self.post_categories.build(category: category)
        end
      end
    end
  end
  
  def fields_blank?
    self.content.empty? || self.user.empty?
  end
  

end
