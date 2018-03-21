class Article < ApplicationRecord
  belongs_to :community
  belongs_to :user

  has_many :article_comments, dependent: :destroy, as: :article_commentable

  validates_presence_of :title, :article
end
