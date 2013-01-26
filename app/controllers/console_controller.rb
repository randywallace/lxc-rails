require 'tempfile'

class ConsoleJob
  @queue = :console
  def self.perform script, path
    puts 'test'
    File.open(path, 'w') do |f|
      10.times do
        f.write(script+"\n")
        f.flush
        sleep(1)
      end
    end
  end
end

class ConsoleController < ApplicationController
  def index
  end

  def read
    sleep 0.1
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
    @path = Tempfile.new('consoleJob').path
    Resque.enqueue(ConsoleJob, @script, @path)
    #ConsoleJob.perform(@script)
    respond_to do |format|
      format.js
    end
  end
end
