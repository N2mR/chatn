module UsersHelper
    def findRoom
        @room = Room.find_by(user_id: current_user.id, other_user_id: @other_user.id)
        if @room
            @room_id = @room.id
        else
            return nil
        end
    end

    def search_relationship_id(user, friend)
        @relationship = user.active_relationships.find_by(followed_id: friend.id, follower_id: user.id)
        if @relationship
            @relationship.id
        else
            return 'notFound'
        end
    end
end
