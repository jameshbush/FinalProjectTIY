require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  def setup
    @report = Report.find(1)
  end

  test "report has survey" do
    assert_equal @report.survey, 1, "Report lacks a survey"
  end

  test "report has postsurvey" do
    assert_equal @report.postsurvey, 1, "Report lacks a postsurvey"
  end
end
