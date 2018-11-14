class EditionsController < ApplicationController
  before_action :check_for_superuser, except: [:index]

  def index
    @editions = Edition.all.order(registration_start_date: :desc)
  end
end
