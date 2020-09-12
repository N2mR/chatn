class Room < ApplicationRecord
  belongs_to :user, dependent: :destroy
  #メッセージ
  has_many :messages

  validates :user_id, presence: true, uniqueness: { scope: :other_user_id }
  validates :other_user_id, presence: true
end
