Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#Index'

  # resources :members DEPRECATED

  get 'home/Index'

  get 'my_communities',
      to: 'home#my_communities',
      as: 'my_communities'


  resources :communities do
    # List community users
    get 'users',
        to: 'communities/community_users#index',
        as: 'users'

    # Kick community user
    delete 'users/:id/',
           to: 'communities/community_users#kick',
           as: 'kick_user'

    # Edit per-community user preferences
    get 'preferences',
        to: 'communities/community_users#edit',
        as: 'user_preferences'
    patch 'preferences',
          to: 'communities/community_users#update'

    # Edit per-community user role
    get 'role/:id',
        to: 'communities/community_users#change_role',
        as: 'role'
    patch 'role/:id',
          to: 'communities/community_users#role'

    # Join a community
    get 'join',
        to: 'communities/community_users#new_join',
        as: 'join'
    post 'join',
         to: 'communities/community_users#join'

    # Leave a community
    delete 'leave',
           to: 'communities/community_users#destroy'

    # Invite user to community
    get 'invite',
        to: 'communities/community_users#new_invite',
        as: 'invite_user'
    post 'invite',
         to: 'communities/community_users#invite'

    resources :forums,
              path: :forum do
      post 'reply',
           to: 'forum_replies#create',
           as: 'reply'
      resources :forum_replies do
        # resources :forum_replies
        post 'reply',
             to: 'forum_replies#create',
             as: 'reply'
      end

    end

    resources :articles,
              path: :article do
      post 'reply',
           to: 'article_comments#create',
           as: 'comment'
      resources :article_comments do
        # resources :article_comments
        post 'reply',
             to: 'article_comments#create',
             as: 'comment'
      end

    end

    resources :events

    get 'manage/events',
        to: 'events#manage',
        as: 'events_manage'

    get 'calendar',
        to: 'events#calendar',
        as: 'calendar'

  end

  devise_for :users, :path_names => {
      :verify_authy => "/verify-token",
      :enable_authy => "/enable-two-factor",
      :verify_authy_installation => "/verify-installation",
      :authy_onetouch_status => "/onetouch-status",
  },
             controllers: {
                 registrations: 'users/registrations',
             }

end
