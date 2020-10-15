module SessionsHelper

    #ユーザーをログインする
    def log_in(user)
        session[:user_id] = user.id
    end

    #カレントユーザーにログインしたユーザーを代入する
    def current_user
        if session[:user_id]
            @current_user ||= User.find_by(id: session[:user_id])
        end
    end

    #引数のユーザーとカレントユーザーが一致するか確かめる
    def current_user?(user)
        user == current_user
    end

    #ユーザーがログインしている状態か確かめる
    def logged_in?
        !current_user.nil?
    end

    #ユーザをログアウトさせる
    def log_out
        session.delete(:user_id)
        @current_user = nil
    end

    #ユーザーがログインしていない状態の時ログインフォームに変遷させる
    def logged_in_user
        unless logged_in?
          redirect_to login_url
        end
    end

    #ルームのセッションを作成する
    def create_session_room
        session[:room] = @room
    end
    #ルームのセッションを削除する
    def destroy_session_room
        session[:room] = nil
    end

    #ユーザIDからユーザを探す
    def find_user(id)
        @user = User.find(id)
        @user
    end
end
