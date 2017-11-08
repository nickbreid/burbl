# Rails.application.config.middleware.use OmniAuth::Builder do
#   provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET']
# end


Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, "1038357891167-pnlq407314j57d7ea2afv0lvvhfauf32.apps.googleusercontent.com", ENV["CLIENT_SECRET"], {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end
