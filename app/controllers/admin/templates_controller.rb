class Admin::TemplatesController < ApplicationController
  before_action :set_template, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  
  load_and_authorize_resource
  skip_load_resource :only => [:create]
  
  respond_to :html

  def index
    @templates = Template.all
    respond_with(@templates)
  end

  def show
    respond_with(@template)
  end

  def new
    @template = Template.new
    respond_with(@template)
  end

  def edit
  end

  def create
    @template = Template.create(title: template_params[:title])

    unless template_params[:item_name].blank?
      template_params[:item_name].each { |item|
        @template.items << Item.new(name: item) unless item.empty?
      }
    end

    if @template.save
      flash[:notice] = "Template successfully create!"
      respond_with([:admin, @template])
    else
      render "new"
    end
  end

  def update
    return render "edit" unless @template.update_attributes(title: template_params[:title])
    
    @template.items.clear
    
    unless template_params[:item_name].blank?
      template_params[:item_name].each { |item|
        @template.items << Item.new(name: item) unless item.empty?
      }
    end
    
    flash[:notice] = "Template successfully update!"
    respond_with([:admin, @template])
  end

  def destroy
    @template.destroy
    respond_with([:admin, @template])
  end

  private
    def set_template
      @template = Template.find(params[:id])
    end

    def template_params
      params.require(:template).permit!
    end
end
