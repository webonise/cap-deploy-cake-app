set :application, 'tutorial'

set :repository, 'git@github.com:webonise/cap-deploy-cake-app.git'

set :branch, 'master'

set :scm, :git

set :deploy_to, '/var/www/capi_app/'

#set :deploy_via, :copy

#set :copy_exclude, [".git/*", ".gitignore"]

#set :copy_compression, :gzip

# Use account tmp dir as /tmp is wierd.

#set :copy_remote_dir, '/home/root/tmp'

#server 'capi.weboapps.com', :app, :web, :db, :primary => false

role :app, "capi.weboapps.com"
role :web, "capi.weboapps.com"
role :db, "capi.weboapps.com", :primary => true

ssh_options[:forward_agent] = true # Agent forwarding keys

set :user, 'root'

#set :use_sudo, false

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app do

    run "#{try_sudo} /etc/init.d/apache2 restart"

    clear_cache
  end

  task :finalize_update, :roles => :app do
    # Link cakephp. Not the ideal linking but it works.
    run "ln -s #{shared_path}/cakephp #{current_release}/cake"

    # Link configuration files
    run "ln -s #{shared_path}/config/core.php #{current_release}/config/core.php"
    run "ln -s #{shared_path}/config/database.php #{current_release}/config/database.php"

    # Link tmp
    run "rm -rf #{current_release}/tmp"
    run "ln -s #{shared_path}/tmp #{current_release}/tmp"
  end
end


namespace :clear_cache do
  desc <<-DESC
    Blow up all the cache files CakePHP uses, ensuring a clean restart.
  DESC
  task :default do
    # Remove absolutely everything from TMP
    run "rm -rf #{shared_path}/tmp/*"

    # Create TMP folders
    run "mkdir -p #{shared_path}/tmp/{cache/{models,persistent,views},sessions,logs,tests}"
  end  
end
