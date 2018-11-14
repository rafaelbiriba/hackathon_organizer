class EditionsController < ApplicationController
  before_action :check_for_superuser, except: [:index, :active_now]

  def active_now
    edition = Edition.active_now
    if edition
      redirect_to edition_projects_url(edition)
    else
      flash[:error] = "There is no edition active right now! Check the list below!"
      redirect_to editions_url
    end
  end

  def index
    @editions = Edition.all.order(registration_start_date: :desc)
  end
end
