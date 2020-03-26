class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :rqstuser, foreign_key: :rqstuser_id, class_name: 'User'

  validates :user_id, presence: true
  validates :rqstuser_id, presence: true

  # Confirmation and deletion methods for processing requests
  class << self
    def confirm_friend(fr_id)
      Friendship.find(fr_id).update(status: true)
    end

    def destroy_request(fr_id)
      Friendship.delete(Friendship.find(fr_id))
    end

    def destroy_friendship(user, rqstuser)
      frienship = Friendship.where(user_id: user, rqstuser_id: rqstuser).first
      inverse_friendship = Friendship.where(user_id: rqstuser, rqstuser_id: user).first
      friendship&.delete
      inverse_friendship&.delete
    end
  end
end
