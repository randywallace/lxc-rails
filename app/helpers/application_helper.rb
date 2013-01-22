module ApplicationHelper
  MEGABYTE = 1024.0 * 1024.0 # to calculate available memory

  def lxc_path
    LXC.run(:ls, '-d').split("\n").first
  end

  def bytes_in_megabytes(bytes)
    (bytes / MEGABYTE).round
  end

  def running_helper(bool)
    bool ? "Running" : "Not Running"
  end

  def lxc_config_path_for(name)
    File.join(lxc_path, name.to_s, 'config')
  end

  def lxc_config_for(name)
    File.open(lxc_config_path_for(name)).read
  end

  def lxc_interfaces_path_for(name)
    f = File.join(lxc_path, name.to_s, "rootfs", "etc", "network", "interfaces")
    if File.exists?(f)
      return f
    else
      return nil
    end
  end

  def lxc_interfaces_for(name)
    path = lxc_interfaces_path_for(name)
    File.open(path).read unless path.nil?
  end

end
