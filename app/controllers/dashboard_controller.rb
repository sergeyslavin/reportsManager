class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
  	@reports = Report.limit(10)
    render 'reports/index' unless flash[:error]
  end
end
