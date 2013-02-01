ClimateStats::Application.routes.draw do
  resources :datasets
  
  root :to => "datasets#index"
  
end
