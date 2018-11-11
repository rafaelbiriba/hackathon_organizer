class EditionsController < ApplicationController
  before_action :check_for_superuser, except: [:index]

  def index
    @editions = Edition.all.order(starts_at: :desc)
  end
end
