Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '327499717302273', '99e86687677186b57c5fbd427d31d28f'
  provider :google, '', ''
  provider :twitter, '',''
end