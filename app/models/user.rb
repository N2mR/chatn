class User < ApplicationRecord
    has_secure_password
    #フレンド登録
    has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
    has_many :following, through: :active_relationships, source: :followed

    has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
    has_many :follower, through: :passive_relationships, source: :follower

    #チャットルーム
    has_many :rooms, dependent: :destroy

    #メッセージ
    has_many :messages, dependent: :destroy

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: {maximum: 225}, format: VALID_EMAIL_REGEX, uniqueness: true
    validates :password, presence: true, length: {minimum: 8}, length: {maximum: 50}
    validates :search_id, presence: true, length: {maximum: 4}, length: {maximum: 15}, uniqueness: true




    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end


    def be_a_friend(other_user)
        following << other_user
    end

    def remove_my_friend(other_user)
        active_relationships.find_by(id: other_user.id).destroy
    end

    def my_friend?(other_user)
        following.include?(other_user)
    end
end
