# http://blog.sosedoff.com/2011/07/24/foreman-capistrano-for-rails-3-applications/
#
# Foreman tasks

Capistrano::Configuration.instance(true).load do
  namespace :foreman do
    desc 'Export the Procfile to Ubuntu upstart scripts'
    task :export, :roles => :app do
      
      run "cd #{release_path} && sudo bundle exec foreman export upstart /etc/init -a #{application} -u #{user} -l #{release_path}/log/foreman", :shell => default_shell

    end
    
    desc "Start the application services"
    task :start, :roles => :app do
      
      sudo "start #{application}"
    end

    desc "Stop the application services"
    
    task :stop, :roles => :app do
      sudo "stop #{application}"
    end

    desc "Restart the application services"
    task :restart, :roles => :app do
      
      run "sudo start #{application} || sudo restart #{application}"
    end
  end
  
  after "deploy:update", "foreman:export"    # Export foreman scripts
  after "deploy:update", "foreman:restart"   # Restart application scripts
end
