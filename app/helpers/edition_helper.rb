module EditionHelper
  def loaded_edition_active?
    @edition.active?
  end

  def any_edition_active_now
    @any_edition_active_now ||= Edition.active_now
  end
end
