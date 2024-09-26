require File.expand_path '../11-webapi_digest_auth', __FILE__

app = Rack::Auth::Digest::MD5.new(Sinatra::Application) do |username|
  # Here we need to return the password for a specific username
  {'john' => 'pass'}[username]
end

app.realm = 'User Area'
app.opaque = 'secretkey'

run app