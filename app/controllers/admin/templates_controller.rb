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
      template_params[:item_name].each { |zero_id, items|
        items.each { |name|
          @template.items << Item.new(name: name) unless name.empty?
        }
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

    # @template.items.clear

    updated_items = []

    unless template_params[:item_name].blank?
      template_params[:item_name].each { |item_id, item_values|

        if !@template.items.exists? or item_id.eql? "0"
          item_values.each { |item_name|
            unless item_name.blank?
              created_item = Item.new(name: item_name)
              @template.items << created_item
              updated_items << created_item.id
            end
          }
        else
          item_values.each { |item_name|
            unless item_name.blank?
              @template.items.find(item_id).update_attributes(name: item_name)
              updated_items << item_id
            end
          }
        end
      }

      removed_items = Item.not_in(:_id => updated_items)
      removed_items.delete_all

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
