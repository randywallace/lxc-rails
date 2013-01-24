module LXC
  class Container
    def root_path
      File.join(LXC.run(:ls, '-d').split("\n").first, name)
    end
    def config_path
      File.join(root_path, 'config')
    end
    def config
      File.open(config_path).read
    end
    def interfaces_path
      f = File.join(root_path, 'rootfs', 'etc', 'network', 'interfaces')
      if File.exists?(f)
        return f
      else
        return nil
      end
    end
    def interfaces
      p = interfaces_path
      File.open(p).read unless p.nil?
    end
    def pslist
      LXC.run(:ps, "-n #{name} -- f")
    end
    def syslog_path
      File.join(root_path, "rootfs", "var", "log", "syslog")
    end
  end
end
        
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
