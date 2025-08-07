class Post < ApplicationRecord
  belongs_to :user

  validates :content, presence: true, length: { maximum: 500 }

  has_many :likes, dependent: :destroy
  has_many :liked_by_users, through: :likes, source: :user

  has_many :comments, dependent: :destroy

end
