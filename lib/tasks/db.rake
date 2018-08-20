namespace :db do
  desc "Create the database, load the schema and run the migrations"
  task :prepare do
    Rake::Task["db:create"].invoke
    Rake::Task["db:schema:load"].invoke
    Rake::Task["db:migrate"].invoke
  end
end
