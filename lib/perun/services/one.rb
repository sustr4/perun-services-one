# Global deps
require 'thor'
require 'opennebula'
require 'json'

require 'pry'

# Define modules
module Perun; end
module Perun::Services; end
module Perun::Services::One; end

require "perun/services/one/version"
require "perun/services/one/master"
require "perun/services/one/target"
require "perun/services/one/reality"

