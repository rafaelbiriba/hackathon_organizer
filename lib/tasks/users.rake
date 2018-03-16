namespace :users do
  desc "Give superuser admin power - Example: rake users:give_superuser['email_address']"
  task :give_superuser, [:email] => :environment do |t, args|
    user = User.find_or_initialize_by(email: args.email)
    user.is_admin = true
    user.is_superuser = true
    user.save!
  end
end
