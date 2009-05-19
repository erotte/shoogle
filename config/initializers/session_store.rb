# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_shoogle_session',
  :secret      => '6b607fb1e022017bd4f23f3fdf79d4a35d009e2003bd6836c707006c8749d82f2e0e393575e19b56cc6e62324b29b9e1878b517846f5db01de4510cb1e639d4a'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
