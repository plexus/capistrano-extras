# http://blog.sosedoff.com/2011/07/24/foreman-capistrano-for-rails-3-applications/
#
# Foreman tasks

Capistrano::Configuration.instance(true).load do
  namespace :foreman do
    desc 'Export the Procfile to Ubuntu upstart scripts'
    task :export, :roles => :app do
      if rvm_ruby_string
        rvm_shell = File.join(rvm_bin_path, "rvm-shell")
        rvm_ruby = rvm_ruby_string.to_s.strip
        bundle_cmd = "rvm_path=#{rvm_path} sudo #{rvm_shell} '#{rvm_ruby}' -c 'bundle %s'"
      else
        bundle_cmd = 'sudo bundle %s'
      end

      run "cd #{release_path} && " + bundle_cmd % "exec foreman export upstart /etc/init -a #{application} -u #{user} -l #{release_path}/log/foreman"
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

    desc "Create environment specific environment file, see '12 Factor App'"
    task :env, :roles => :app do
      put "RAILS_ENV=#{rails_env}\n#{foreman_env}", release_path + '/.env'
    end
  end
  
  after "deploy:update", "foreman:export"    # Export foreman scripts
  after "deploy:update", "foreman:restart"   # Restart application scripts
  after "deploy:update", "foreman:env"   # Restart application scripts
end
