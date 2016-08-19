class ArticleCategory < ActiveRecord::Base

  belongs_to :article
  belongs_to :category

  validates_uniqueness_of :article_id, :scope => :category_id, message: ' already exists in that category'

end