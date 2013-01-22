class ContainersController < ApplicationController

  def index
    @containers = Container.all
  end

  def show
    @container = Container.find(params[:id])
  end

  def conf
    @container = Container.find(params[:id])
    @config_data = view_context.lxc_config_for(@container.name)
  end
  
  def interfaces
    @container = Container.find(params[:id])
    @config_data = view_context.lxc_interfaces_for(@container.name) 
    @config_data = "DEAD" if @config_data.nil?
  end
end
