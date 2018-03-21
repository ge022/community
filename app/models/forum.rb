class Forum < ApplicationRecord
  belongs_to :user
  belongs_to :community

  has_many :forum_replies, dependent: :destroy, as: :forum_commentable

  validates_presence_of :title, :post
end
