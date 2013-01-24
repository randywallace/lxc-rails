module ApplicationHelper
  MEGABYTE = 1024.0 * 1024.0 # to calculate available memory

  def bytes_in_megabytes(bytes)
    (bytes / MEGABYTE).round
  end

  def running_helper(bool)
    bool ? "Running" : "Stopped"
  end

end
