module ApplicationHelper
  #################################################
  # navbar
  def navbar_menu
    build_menu 'nav navbar-nav navbar-right' do
      if user_signed_in?
        user_setting_menu_items
      else
        authorization_menu_items
      end
    end
  end

  def authorization_menu_items
    build_menu_items(*[['Sign In', new_user_session_path], ['Sign Up', new_user_registration_path]])
  end

  def user_setting_menu_items
    build_menu_items(*[
      [messages_title_for_link, messages_path],
      ['Users', users_path],
      ['Settings', edit_user_registration_path],
      ['Log Out', destroy_user_session_path, method: :delete]
    ])
  end
  # navbar
  #################################################

  #################################################
  # Builders
  def build_menu classes = '', &block
    content_tag :ul, class: classes, &block
  end

  def build_menu_items *items
    items.map do |item|
      build_menu_item(*item)
    end.join.html_safe
  end

  def build_menu_item name, link = nil, options = nil
    content_tag :li do
      link_to name, link, options
    end.html_safe
  end
  # Builders
  #################################################

  def messages_title_for_link
    if not current_user.recived_messages.last.nil? and current_user.recived_messages.last.created_at > current_user.last_seen_messages
      'Messages (+)'
    else
      'Messages'
    end
  end
end
