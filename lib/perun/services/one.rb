# Global deps
require 'thor'
require 'opennebula'
require 'json'
require 'logger'
require 'securerandom'

require 'pry'

# Define modules
module Perun; end
# All Perun services, a.k.a. slaves
module Perun::Services; end
# Specific Perun service for OpenNebula userbase synchronization
module Perun::Services::One; end

require 'perun/services/one/version'
require 'perun/services/one/master'
require 'perun/services/one/state'
require 'perun/services/one/target'
require 'perun/services/one/reality'
