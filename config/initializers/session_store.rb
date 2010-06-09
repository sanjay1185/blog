# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_blog_session',
  :secret      => '154ca79bfd06dbb1e8f642e077f1eb71f54f9805bc1c386bb0bb912e9aafcd023f41e2204ca117787bdb53508ee5e4b0962b7e3ee424cea4b69b2e0a7195d3c7'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
