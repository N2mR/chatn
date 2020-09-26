class Room < ApplicationRecord
  belongs_to :user
  #メッセージ
  has_many :messages, dependent: :destroy

  validates :user_id, presence: true, uniqueness: { scope: :other_user_id }
  validates :other_user_id, presence: true
end
