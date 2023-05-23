if Rails.env.production? && ENV['SECRET_TOKEN'].blank?
  fail 'SECRET_TOKEN enviroment variable must be set'
end

PullrequestCopy::Application.config.secre_key_base = 
ENV['SECRET_TOKEN'] || '9e54bbeeb2a8573aee35f49c56406f705443fc4afc9e7037a79b9cd8065b592df6d97b5f41ba12acc46fdf61a60363e00ea2debae684bad89cfd5a2b74049091'