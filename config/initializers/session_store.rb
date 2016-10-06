# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_congregation_session',
  :secret      => 'aff31642569576efe5d9e35374300142d49f74dc1491b30abc896734817865971327eac02dc1fcd4ea8db58cb6cdb92f7faf0148aa1991b450f50757132d5946'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
