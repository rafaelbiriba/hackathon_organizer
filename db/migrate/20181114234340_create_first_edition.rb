class CreateFirstEdition < ActiveRecord::Migration[5.1]
  def up
    # Populate the current application with the first edition
    return if Edition.count > 0
    edition = Edition.create!(title: "Hackathon Migration", registration_start_date: Time.now, start_date: Time.now, end_date: Time.now)
    Project.all.each do |p|
      p.edition = edition
      p.save!
    end
  end
end
