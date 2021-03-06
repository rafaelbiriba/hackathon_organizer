return if Rails.env.production?

USER_COUNT = 200
SUPER_USER_COUNT = 1
ADMIN_COUNT = 1
PROJECTS_COUNT = 50
PROJECTS_COUNT_WITH_SUBSCRIBERS = 30
PROJECTS_COUNT_WITH_LIKES = 20
PROJECTS_COUNT_WITH_SUBSCRIBERS_WITH_LIKES = 20
MAX_COMMENTS_PER_PROJECT = 10

####################################################################
@super_users = []
@admin_users = []
@users = []
@projects = []

## Creating Users
SUPER_USER_COUNT.times do
  @super_users << FactoryBot.create(:user, is_admin: true, is_superuser: true)
end

ADMIN_COUNT.times do
  @admin_users << FactoryBot.create(:user, is_admin: true, is_superuser: true)
end

USER_COUNT.times do
  @users << FactoryBot.create(:user)
end

@all_users = @super_users + @admin_users + @users


## Creating Projects for admins
(@super_users + @admin_users).each do |user|
  @projects << FactoryBot.create(:project, owner: user)
end

## Creating Projects
PROJECTS_COUNT.times do
  @projects << FactoryBot.create(:project, owner: @users.sample)
end

PROJECTS_COUNT_WITH_SUBSCRIBERS.times do
  subscribers = @all_users.sample(rand(1..@all_users.count)) #Random pick the subscribers and quantity
  @projects << FactoryBot.create(:project, owner: @users.sample,
                              subscribers: subscribers)
end

PROJECTS_COUNT_WITH_LIKES.times do
  project = FactoryBot.create(:project, owner: @users.sample)
  @projects << project
  likers = @all_users.sample(rand(1..@all_users.count)) #Random pick the likers and quantity
  likers.each do |user|
    FactoryBot.create(:thumbs_up, project: project, creator: user)
  end
end

PROJECTS_COUNT_WITH_SUBSCRIBERS_WITH_LIKES.times do
  subscribers = @all_users.sample(rand(1..@all_users.count)) #Random pick the subscribers and quantity
  project = FactoryBot.create(:project, owner: @users.sample,
                              subscribers: subscribers)
  @projects << project
  likers = @all_users.sample(rand(1..@all_users.count)) #Random pick the likers and quantity
  likers.each do |user|
    FactoryBot.create(:thumbs_up, project: project, creator: user)
  end
end

## Creating random comments
projects_with_comments = rand(@projects.count/2..@projects.count) #Ensure half of project with comments
@projects.sample(projects_with_comments).each do |project|
  rand(5..MAX_COMMENTS_PER_PROJECT).times do
    FactoryBot.create(:comment, project: project, owner: @users.sample)
  end
end
