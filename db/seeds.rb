return if Rails.env.production?

admin = FactoryBot.create(:user, is_admin: true, is_superuser: true)
user1 = FactoryBot.create(:user, is_admin: true)
user2 = FactoryBot.create(:user)

project1 = FactoryBot.create(:project, owner: admin)
project2 = FactoryBot.create(:project, owner: user1)
project3 = FactoryBot.create(:project, owner: user2)
project4 = FactoryBot.create(:project, owner: user1, subscribers: [admin, user2])
project5 = FactoryBot.create(:project, owner: user2, subscribers: [user1])

commment1_project1 = FactoryBot.create(:comment, project: project1, owner: user1)
commment2_project1 = FactoryBot.create(:comment, project: project1, owner: user2)
commment3_project1 = FactoryBot.create(:comment, project: project1, owner: user1)
commment4_project1 = FactoryBot.create(:comment, project: project1, owner: admin)
commment5_project2 = FactoryBot.create(:comment, project: project2, owner: admin)

thumbs_up1_project3 = FactoryBot.create(:thumbs_up, project: project3, creator: user1)
thumbs_up2_project3 = FactoryBot.create(:thumbs_up, project: project3, creator: user2)
thumbs_up3_project5 = FactoryBot.create(:thumbs_up, project: project5, creator: admin)
