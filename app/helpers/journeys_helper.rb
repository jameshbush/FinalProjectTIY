module JourneysHelper
  def active_journey
    @active_journey ||= current_user.current_journey
  end
end
