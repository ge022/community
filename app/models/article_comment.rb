class ArticleComment < ApplicationRecord
  belongs_to :community
  belongs_to :user

  belongs_to :article_commentable, polymorphic: true
  has_many :article_comments, as: :article_commentable, dependent: :destroy

  validates_presence_of :comment
end
