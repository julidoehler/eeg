# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_eeg_session',
  :secret      => '0d8e9636d67128a016bc760c1e76fa27f8ab20f88280519f4d0f404b3e6d5c1a984328210dc7c5688c6d9b49a803236b33d7a269d4a6028243808732907885bd'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
