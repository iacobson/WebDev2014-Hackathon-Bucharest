Rails.application.routes.draw do
  

  root to: 'voters#index'
  resources :voters, param: :cnp
  resources :alerts
  devise_for :users, :controllers => { registrations: 'registrations' }

  get '/showvoters' => 'voters#showvoters'
  post '/votetime' => 'voters#votetime'

  get '/alertshall' => 'voters#alertshall'
  get '/representatives' => 'voters#representatives'
  get '/statistics' => 'voters#statistics'
  get '/voternotfound' => 'voters#voternotfound'

  post 'search_voter' => 'voters#search_voter'
  post 'create_alert' => 'voters#create_alert'
  post 'double_voting' => 'voters#double_voting'
end
