class EditionsController < ApplicationController
  before_action :validate_admin_user, except: [:index, :show, :active_now]

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

  def show
    redirect_to edition_projects_url(edition_id: params[:id])
  end

  def new
    @edition = Edition.new
    @edition.registration_start_date = Time.now
    @edition.start_date = Time.now
    @edition.end_date = Time.now
  end

  def edit
    @edition ||= Edition.find(params[:id])
  end

  def create
    @edition = Edition.new(editions_params)

    if @edition.save
      redirect_to editions_url, notice: "Edition was successfully created"
    else
      render :new
    end
  end

  def update
    @edition = Edition.find(params[:id])
    if @edition.update(editions_params)
      redirect_to editions_url, notice: "Edition #{@edition.title} was successfully updated."
    else
      render :edit
    end
  end


  private
  def editions_params
    params.require(:edition).permit(:title, :registration_start_date, :start_date, :end_date)
  end
end
