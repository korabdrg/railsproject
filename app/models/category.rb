class Category < ApplicationRecord
    validates :name, presence:true, 
    uniqueness:true, length:{maximum:25, minimum:3}
    has_many :article_categories
    has_many :articles, through: :article_categories
end