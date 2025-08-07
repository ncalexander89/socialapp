class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Sent follow requests (user initiated)
  has_many :sent_follow_requests, class_name: "FollowRequest", foreign_key: "sender_id", dependent: :destroy

  # Received follow requests (user is the target)
  has_many :received_follow_requests, class_name: "FollowRequest", foreign_key: "receiver_id", dependent: :destroy

  # Users who this user is following
  has_many :accepted_sent_requests, -> { where(status: "accepted") }, class_name: "FollowRequest", foreign_key: "sender_id"
  has_many :following, through: :accepted_sent_requests, source: :receiver

  # Users who follow this user
  has_many :accepted_received_requests, -> { where(status: "accepted") }, class_name: "FollowRequest", foreign_key: "receiver_id"
  has_many :followers, through: :accepted_received_requests, source: :sender

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post

  has_many :comments, dependent: :destroy

  has_one_attached :avatar

  after_create :send_welcome_email

private

def send_welcome_email
  UserMailer.welcome_email(self).deliver_later
end
end
