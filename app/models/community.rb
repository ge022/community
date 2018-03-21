class Community < ApplicationRecord
  has_many :members, dependent: :destroy
  has_many :users, :through => :members
  has_many :forums, dependent: :destroy
  has_many :forum_replies, through: :forums, dependent: :destroy
  has_many :articles, dependent: :destroy
  has_many :article_comments, through: :articles, dependent: :destroy

  has_many :events, dependent: :destroy

  validates_presence_of :name, :description

end
