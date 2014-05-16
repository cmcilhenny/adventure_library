AdventureLibrary::Application.routes.draw do
  root 'adventures#index'

  resources :libraries

  resources :adventures do
    resources :pages
  end
  
end
