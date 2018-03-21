class Member < ApplicationRecord
  belongs_to :community
  belongs_to :user

  # set_user_id for Communities::MembersController.invite
  before_validation :set_user_id, if: :email?

  validates :email, presence: true
  validates :role, inclusion: { in: ['member', 'admin'] }
  validates :display_name, presence: true

  def set_user_id
    # Lookup User by email address, and assign the user.
    # if one doesn't exist, send an invite email.
    self.user = User.invite!(email: email)
  end

end
