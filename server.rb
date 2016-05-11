require 'sinatra'
require 'braintree'

get '/' do
  Braintree::Configuration.environment = :sandbox
  Braintree::Configuration.merchant_id = "g69y3s9mhk8r4w82"
  Braintree::Configuration.public_key = "jqfjdjh4kw3b4q6c"
  Braintree::Configuration.private_key = "b24afd95c33f27f41d6fed4073173d40"
  bt_token = Braintree::ClientToken.generate
  haml :index, locals: {bt_token: bt_token}
end
