module SessionsHelper
  def login(user)
    session[:user_id] = user.id
  end

  def current_user
    if session[:user_id]
      User.find_by(id: session[:user_id])
    elsif cookies.permanent.signed[:user_id]
      user = User.find_by(id: cookies.permanent.signed[:user_id])
      if user && user.authenticated?(cookies.permanent[:remember_token])
        login(user)
        user
      end
    end
  end

  def logged_in?
    if current_user
      return true
    end
  end

  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def logout
    if logged_in?
      forget(current_user)
      session.delete(:user_id)
      current_user = nil
    end
  end
end
