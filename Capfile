load 'deploy' if respond_to?(:namespace) # cap2 differentiator
Dir['vendor/gems/*/recipes/*.rb','vendor/plugins/*/recipes/*.rb'].each { |plugin| load(plugin) }

load 'config/deploy' # remove this line to skip loading any of the default tasks

set :application, 'tutorial'

set :repository, 'git@github.com:webonise/cap-deploy-cake-app.git'

set :branch, 'master'

set :scm, :git

set :deploy_to, '/var/www/Apps2011/'

set :deploy_via, :copy

set :copy_exclude, [".git/*", ".gitignore"]

set :copy_compression, :gzip

# Use account tmp dir as /tmp is wierd.

set :copy_remote_dir, '/home/root/tmp'

server 'capi.weboapps.com', :app, :primary => true

set :user, 'root'

set :use_sudo, true

# Environments
#task :production do
#  set :deploy_to, '/var/www/Apps2011/'
#end