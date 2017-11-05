namespace :users do
  desc "Give admin power - Example: rake users:give_admin['email_address']"
  task :give_admin, [:email] => :environment do |t, args|
    user = User.find_or_initialize_by(email: args.email)
    user.is_admin = true
    user.save!
  end
end
