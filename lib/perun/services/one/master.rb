# Main class defining executable actions, especially the default sync action
class Perun::Services::One::Master < ::Thor
  desc 'sync', 'Synchronize user base with OpenNebula'
  def sync
    # TODO: Move all this into options and conf. file
    file = File.new('/tmp/opennebula.json', 'r')
    ignore_users = %w(oneadmin serveradmin rocci)
    options = {
      'authDriver' => 'x509',
      'rpc_endpoint' => ENV['ONE_XMLRPC'],
      'principalTypes' => %w(cert_dns principals)
    }

    logger = Logger.new(STDERR)
    logger.level = Logger::DEBUG

    target = Perun::Services::One::Target.new(file.read, options)
    reality = Perun::Services::One::Reality.new(options, logger)

    users_to_add = target.users - reality.users
    users_to_remove = reality.users - target.users - ignore_users
    logger.debug("#{users_to_add.count} users to add, #{users_to_remove.count} users to remove.")

    # TODO: Implelement ignored users (method to remove them from all lists?)

    users_to_add.each do |user|
      logger.info("Creating user #{user}.")
      reality.add_user(user)
    end
  end
  default_task :sync
end
