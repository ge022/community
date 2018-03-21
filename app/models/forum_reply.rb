class ForumReply < ApplicationRecord
  belongs_to :community
  belongs_to :user

  belongs_to :forum_commentable, polymorphic: true
  has_many :forum_replies, as: :forum_commentable, dependent: :destroy

  validates_presence_of :post
end
