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
  end

  def start
    container = LXC.container(params[:id])
    if container.exists?
      container.start
      sleep 0.5
      redirect_to '/', :flash => {:notice => "Successfully started #{container.name}"}
    else
      redirect_to '/', :flash => {:error => "#{container.name} already running"}
    end
  end

  def stop
    container = LXC.container(params[:id])
    if container.exists? && container.running?
      container.stop
      sleep 0.5
      redirect_to '/', :flash => {:notice => "Successfully stopped #{container.name}"}
    else
      redirect_to '/', :flash => {:error => "#{container.name} already stopped"}
    end
  end
end
