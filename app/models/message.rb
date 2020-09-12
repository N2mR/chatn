class Message < ApplicationRecord
  belongs_to :user, dependent: :destroy
  belongs_to :room, dependent: :destroy
  validates :content, presence: true
  validates :user_id, presence: true
end
