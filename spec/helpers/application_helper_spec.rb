describe ApplicationHelper, type: :helper do
  #################################################
  # navbar
  context 'navbar' do
    let(:sign_in_link) { '<li><a href="/users/sign_in">Sign In</a></li>' }
    let(:sign_up_link) { '<li><a href="/users/sign_up">Sign Up</a></li>' }

    let(:messages_path_link_with_new)    { '<li><a href="/messages">Messages (+)</a></li>' }
    let(:messages_path_link_with_no_new) { '<li><a href="/messages">Messages</a></li>' }
    let(:users_path_link)                { '<li><a href="/users">Users</a></li>' }
    let(:settings_link)                  { '<li><a href="/users/edit">Settings</a></li>' }
    let(:sign_out_link)                  { '<li><a rel="nofollow" data-method="delete" href="/users/sign_out">Log Out</a></li>' }

    let(:authorization_menu_items)                        { sign_in_link  + sign_up_link }
    let(:user_setting_menu_items_with_unread_messages)    { messages_path_link_with_new    + users_path_link + settings_link + sign_out_link }
    let(:user_setting_menu_items_with_no_unread_messages) { messages_path_link_with_no_new + users_path_link + settings_link + sign_out_link }

    context '.navbar_menu' do
      helper do
        def user_signed_in?
          @user.present?
        end
      end

      let(:navbar_auth_menu)                         { '<ul class="nav navbar-nav navbar-right">' + authorization_menu_items + '</ul>' }
      let(:navbar_sett_menu_with_unread_messages)    { '<ul class="nav navbar-nav navbar-right">' + user_setting_menu_items_with_unread_messages     + '</ul>' }
      let(:navbar_sett_menu_with_no_unread_messages) { '<ul class="nav navbar-nav navbar-right">' + user_setting_menu_items_with_no_unread_messages  + '</ul>' }

      it 'should return authorization menu' do
        expect(helper.navbar_menu).to eql navbar_auth_menu
      end

      context 'with no unread messages' do
        helper do
          def current_user
            o = Object.new
            def o.recived_messages; m = Object.new; def m.last; nil; end; m; end
            o
          end
        end

        it 'should return user settings menu' do
          @user = true
          expect(helper.navbar_menu).to eql navbar_sett_menu_with_no_unread_messages
        end

        context '.user_setting_menu_items' do
          it 'should return user_setting_menu_items menu items' do
            expect(helper.user_setting_menu_items).to eql user_setting_menu_items_with_no_unread_messages
          end
        end
      end

      context 'with unread messages' do
        helper do
          def current_user
            o = Object.new
            def o.recived_messages; m = Object.new; def m.last; i = Object.new; def i.created_at; Time.now end; i end; m; end
            def o.last_seen_messages; 1.month.ago; end
            o
          end
        end

        it 'should return user settings menu' do
          @user = true
          expect(helper.navbar_menu).to eql navbar_sett_menu_with_unread_messages
        end

        context '.user_setting_menu_items' do
          it 'should return user_setting_menu_items menu items' do
            expect(helper.user_setting_menu_items).to eql user_setting_menu_items_with_unread_messages
          end
        end
      end
    end

    context '.authorization_menu_items' do
      it 'should return authorization menu items' do
        expect(helper.authorization_menu_items).to eql authorization_menu_items
      end
    end
  end
  # navbar
  #################################################

  #################################################
  # Builders
  context 'builders' do
    let(:google) { ['Google', 'http://google.com'] }
    let(:yandex) { ['Yandex', 'http://yandex.ru' ] }

    let(:parsed_google) { '<li><a href="http://google.com">Google</a></li>' }
    let(:parsed_yandex) { '<li><a href="http://yandex.ru">Yandex</a></li>'  }

    context '.build_menu' do
      it 'should return menu' do
        expect(
          helper.build_menu('navbar') do
            helper.build_menu_items(google, yandex)
          end
        ).to eql [
          '<ul class="navbar">',
          parsed_google,
          parsed_yandex,
          '</ul>',
        ].join
      end
    end

    context '.build_menu_items' do
      it 'should return several menu items' do
        expect(helper.build_menu_items(google, yandex)).to eql(parsed_google + parsed_yandex)
      end
    end

    context '.build_menu_item' do
      it 'should return menu item' do
        expect(helper.build_menu_item(*google)).to eql(parsed_google)
      end
    end
  end
  # Builders
  #################################################
end