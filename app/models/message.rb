class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room
  validates :content, presence: true
  validates :user_id, presence: true
end
