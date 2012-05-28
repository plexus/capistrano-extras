namespace :postgresql do
  desc 'Create a PostgreSQL user'
  task :create_role do 
    run "echo 'CREATE USER #{db_user} WITH PASSWORD '#{db_password};' | sudo -u postgres psql"
  end

  desc 'Create a PostgreSQL database'
  task :create_db do 
    run "echo 'CREATE DATABASE #{db_name}; GRANT ALL ON DATABASE #{db_name} TO #{db_user};' | sudo -u postgres psql"
  end
end
