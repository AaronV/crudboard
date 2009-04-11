# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_crudboard_session',
  :secret      => '4d4ac13907d3781818464100e2f943e4b33e343bfe977a0d264fef8de61c18d1a8bb8596e227a25f5ddf71e3286e4eef48eac07dabb597c61072cfe9054cd866'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
