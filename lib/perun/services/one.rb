# Global deps
require 'thor'
require 'opennebula'
require 'json'
include OpenNebula

# Define modules
module Perun; end
module Perun::Services; end
module Perun::Services::One; end

require "perun/services/one/version"
require "perun/services/one/master"

