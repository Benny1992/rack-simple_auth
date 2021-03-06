require 'rack/simple_auth/version'
require 'rack/simple_auth/logger'

# HMAC utilities
require 'rack/simple_auth/hmac/config'
require 'rack/simple_auth/hmac/request'
require 'rack/simple_auth/hmac/middleware'

require 'json'
require 'openssl'

# Rack Module
module Rack
  # Module which Contains different Authorization / Authentication Classes (HMAC, ..)
  module SimpleAuth
    class << self
      ##
      # Method to return Gem Root Dir from everywhere in the gem
      #
      # @return [String] Gem Root Folder
      def root
        ::File.dirname(::File.dirname(::File.expand_path('..', __FILE__)))
      end
    end
  end
end
