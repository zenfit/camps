require 'sinatra'
require 'stripe'

set :stripe_publishable_key, ENV['STRIPE_PUBLISHABLE_KEY']
set :stripe_secret_key, ENV['STRIPE_SECRET_KEY']

Stripe.api_key = settings.stripe_secret_key

get '/' do
  haml :index
end

post '/charge' do
  @amount = 40000
  
  # find or create customer?
  customer = Stripe::Customer.create(
    email: params[:email],
    source: params[:stripeToken]
  )
  
  # sign up for a product here..
  charge = Stripe::Charge.create(
    amount: @amount,
    description: 'ZenFit Kids Camp Session 1',
    currency: 'usd',
    customer: customer.id
  )
end

__END__

@@ layout
!!!
%html
  %head
    %title ZenFit Kids Camps
    %link{:href => "/stylesheets/main.css", :rel => "stylesheet", :type => "text/css"}/
    %link{:crossorigin => "anonymous", :href => "https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css", :integrity => "sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7", :rel => "stylesheet"}/
    %script{:crossorigin => "anonymous", :integrity => "sha256-a23g1Nt4dtEYOj7bR+vTu7+T8VP13humZFBJNIYoEJo=", :src => "https://code.jquery.com/jquery-2.2.3.min.js"}
    %script{:crossorigin => "anonymous", :integrity => "sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS", :src => "https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"}
  %body
    = yield