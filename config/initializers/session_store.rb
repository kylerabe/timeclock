# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_timeclock_session',
  :secret      => '0f5d848bb0a6824d3997b2f38fc8b7e090d5cacddae5d27c3d85c53171339dae9f675012141eb22a6981bc95c4fbc8d79172d6899adfe53e77b137694308f41d'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
