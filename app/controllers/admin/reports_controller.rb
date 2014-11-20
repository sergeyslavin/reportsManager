class Admin::ReportsController < ApplicationController
  before_action :set_report, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  respond_to :html

  def index
    @reports = Report.all
    respond_with(@reports)
  end

  def show
    respond_with(@report)
  end

  def new
    @report = Report.new
    respond_with(@report)
  end

  def edit
  end

  def create
    @report = Report.new(report_params)
    @report.save
    respond_with([:admin, @report])
  end

  def update
    @report.update(report_params)
    respond_with([:admin, @report])
  end

  def destroy
    @report.destroy
    respond_with([:admin, @report])
  end

  private
    def set_report
      @report = Report.find(params[:id])
    end

    def report_params
      params.require(:report).permit(:title)
    end
end
