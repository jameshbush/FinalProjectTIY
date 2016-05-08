module ReportsHelper
  def report_due?
    !active_journey.reports.find_by(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
  end

  def active_report
    active_journey.reports.find_by(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
  end
end
