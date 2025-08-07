class FollowRequest < ApplicationRecord
  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"

  validates :sender_id, uniqueness: { scope: :receiver_id, message: "has already sent a follow request" }
  validate :cannot_follow_self

  def cannot_follow_self
    errors.add(:receiver_id, "can't be yourself") if sender_id == receiver_id
  end
end
