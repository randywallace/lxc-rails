require 'resque-status'

class ConsoleJob 
  include Resque::Plugins::Status
  @queue = :console
  require 'open4'
  def perform 
    script = options['script']
    path = options['path']
    File.open(path, 'w') do |f|
      f.sync = true
      t = Open4::bg script, 1=>f, 2=>f
      ticker_var = true
      ticker = Thread.new do
        while ticker_var
          tick
          sleep 0.5
        end
      end
      waiter = Thread.new do 
        t.exitstatus
        f.flush
      end
      waiter.join
      ticker_var = false
      tick.join
    end
  end
end

class ConsoleController < ApplicationController
  def index
  end

  def stop
    @status = Resque::Plugins::Status::Hash.get(params[:job])
    Resque::Plugins::Status::Hash.kill(params[:job])
    @job_id = @status.uuid
    respond_to do |format|
      format.js
    end
  end

  def read
    @status = Resque::Plugins::Status::Hash.get(params[:job])
    f = File.open(params[:id], 'r')
    @data = f.read
    f.close
    respond_to do |format|
      format.js
    end
  end

  def run
    session[:script] = params["console"]["script"]
    @script = params["console"]["script"]
    @path = '/tmp/consoleJob-' + Time.now.strftime('%s')
    File.open(@path, 'w') { |f| f.write("Running: #{@script}...\n") }
    @job_id = ConsoleJob.create(script: @script, path: @path)
    logger.info @job_id
    #ConsoleJob.perform(@script, @path)
    respond_to do |format|
      format.js
    end
  end
end
