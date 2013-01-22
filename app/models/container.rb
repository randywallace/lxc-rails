class Container

  def self.all
    LXC.containers
  end

  def self.find param
    container = LXC.container(param) 
    if container.exists?
      return container
    end 
    raise(ActiveRecord::RecordNotFound)
  end

  def self.where query
  end

  def initialize item
  end

  def include? query
  end

  protected

  def self.get_containers
  end

  class LXCInstallationNotFound < Exception
  end

end
