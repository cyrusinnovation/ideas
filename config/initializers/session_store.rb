# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_pointilist_session',
  :secret      => '2f28aef4479f4e8c36dbf8d707f3b91b2864412e15b9a7be84cc278fb3f0c3deea8d27ccdfe900a269d9e3eb5aecae8ab362aee583d57f88dad00fb4d7ffdcdb'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
