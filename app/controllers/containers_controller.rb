class ContainersController < ApplicationController

  def index
    @containers = Container.all
  end

  def write_config
    config_path = params[:path]
    content     = params[:config].gsub!("\r\n", "\n")
    begin
      File.open(config_path, 'w') do |file|
        file.write(content)
      end
      redirect_to '/containers/' + params[:id], flash: { notice: "#{config_path} saved successfully"}
    rescue Exception => e
      redirect_to '/containers/' + params[:id], flash: { error:  "#{config_path} could not be saved: #{e.message}"}
    end
  end

  def show
    @container = Container.find(params[:id])
  end

  def conf
    @container = Container.find(params[:id])
    @config_data = @container.config
  end
  
  def interfaces
    @container = Container.find(params[:id])
    @config_data = @container.interfaces
  end

  def pslist
    @container = Container.find(params[:id])
  end

  def syslog
    @container = Container.find(params[:id])
    @lines = `tail -50 #{ @container.syslog_path }`.split(/\n/).reverse
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
