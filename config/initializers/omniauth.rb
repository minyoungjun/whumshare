OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '562260310492321', '9b209a9e006a2244f69419ee5a2b2355'
end
