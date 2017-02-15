
class Perun::Services::One::Master < ::Thor
  desc 'sync', 'Synchronize user base with OpenNebula'
  def sync

    puts "Yep, I'm here"

  end
  default_task :sync
end

