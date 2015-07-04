role :app, %w{deploy@45.55.91.184}
role :web, %w{deploy@45.55.91.184}
role :db, %w{deploy@45.55.91.184}

# Extended Server Syntax
#otro comentario
# ======================
# This can be used to drop a more detailed server
# definition into the server list. The second argument
# something that quacks like a hash can be used to set
# extended properties on the server.
server '45.55.91.184', user: 'deploy', roles: %w{web app}
set :stage, :production
