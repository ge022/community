class User < ApplicationRecord
  has_many :members
  has_many :communities, :through => :members

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :authy_authenticatable, :database_authenticatable

  validates :email, uniqueness: true
  validates :time_zone, inclusion: { in: ActiveSupport::TimeZone.all.map(&:name) }

  # Email attribute for CommunityUser
  attribute :email, :string
  
end
