class ReportsController < ApplicationController
  before_action :set_report, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  load_and_authorize_resource :except => [:show, :index]
  skip_load_resource :only => [:create]

  respond_to :html

  def index
    @reports = Report.all
    respond_with(@reports)
  end

  def show
    @items_value = @report.item_values.group_by { |e| e.item_id }
    respond_with(@report)
  end

  def new
    @report = Report.new
    @template ||= nil

    unless params[:template].nil?
      @template = Template.find(params[:template])
    else
      not_found
    end

    respond_with(@report)
  end

  def templates
    @templates = Template.all
  end

  def edit
    @template = Template.find(@report.template_id)
  end

  def create
    @template = Template.find(report_params[:template_id])
    @report = Report.create(title: report_params[:title])
    @template.reports << @report

    unless report_params[:item_value].blank?
      report_params[:item_value].each { |item_id, items|
        items.each { |item_value|
          @report.item_values << ItemValue.new(value: item_value, item_id: item_id)
        }
      }
    end

    if @report.save
      flash[:notice] = "Report successfully create!"
      respond_with(@report)
    else
      render "new"
    end
  end

  def update
    @template = Template.find(report_params[:template_id])

    return render "edit" unless @report.update_attributes(title: report_params[:title])

    @report.item_values.clear

    unless report_params[:item_value].blank?
      report_params[:item_value].each { |item_id, items|
        items.each { |item_value|
          @report.item_values << ItemValue.new(value: item_value, item_id: item_id) unless item_value.empty?
        }
      }
    end

    flash[:notice] = "Report successfully update!"
    respond_with(@report)
  end

  def destroy
    @report.destroy
    respond_with(@report)
  end

  private
    def not_found
      raise ActionController::RoutingError.new('Not Found')
    end

    def set_report
      @report = Report.find(params[:id])
    end

    def report_params
      params.require(:report).permit!
    end
end
