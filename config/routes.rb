Rails.application.routes.draw do
  get 'user/pdf_to_jpg'
  post 'user/do_pdf_to_jpg'

  get 'user/word_to_pdf'
  post 'user/do_word_to_pdf'

  get 'user/pdf_to_word'
  post 'user/do_pdf_to_word'

  get 'user/excel_to_pdf'
  post 'user/do_excel_to_pdf'

  get 'user/jpg_to_pdf'
  post 'user/do_jpg_to_pdf'

  get 'user/unlock_pdf'
  post 'user/do_unlock_pdf'

  get 'user/pdf_to_ppt'
  post 'user/do_pdf_to_ppt'

  get 'user/ppt_to_pdf'
  post 'user/do_ppt_to_pdf'

  get 'user/split_pdf'
  post 'user/do_split_pdf'

  get 'user/compress_pdf'
  post 'user/do_compress_pdf'

  get 'user/watermark_pdf'
  post 'user/ask_watermark'
  post 'user/do_watermark_image'

  get 'public/home'
  root 'public#home'

  get 'user/merge_pdf'
  post 'user/do_merge_pdf'

  get 'user/pdf_to_excel'
  post 'user/do_pdf_to_excel'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
