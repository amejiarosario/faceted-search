#
# http://www.postgresql.org/docs/9.0/static/app-pg-ctl.html
#
namespace :postgres do
  desc "Start postgres"
  task :start do
    puts `pg_ctl start -D /usr/local/psql2/data -l log/database.log`
  end
  
  desc "Stop postgres"
  task :stop do
    puts `pg_ctl stop -D /usr/local/psql2/data`
  end

  desc "Restart postgres"
  task :restart do
    puts `pg_ctl restart -D /usr/local/psql2/data`
  end  

  desc "Status postgres"
  task :status do
    puts `pg_ctl status -D /usr/local/psql2/data`
  end  
  
end