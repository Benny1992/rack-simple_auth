module Rack
  module SimpleAuth
    module HMAC
      ##
      # Config objects will be instantiated out of this class when using Rack::SimpleAuth::HMAC::Middleware
      # Also the public instance attributes / virtual attributes will be populated via the Middleware DSL
      #
      # @!attribute [w] tolerance
      #  @return [Fixnum|Float]
      #
      # @!attribute [w] secret
      #  @return [String]
      #
      # @!attribute [w] signature
      #  @return [String]
      #
      # @!attribute [rw] logpath
      #  @return [String]
      #
      # @!attribute [rw] request_config
      #  @return [Hash]
      #
      # @!attribute [rw] verbose
      #  @return [TrueClass|NilClass]
      #
      class Config
        attr_writer :tolerance
        attr_writer :secret, :signature

        attr_accessor :verbose
        attr_accessor :logpath, :request_config

        ##
        # Throw Runtime error for unknown attribute
        #
        # @param [Symbol] name
        # @param [Array] args
        #
        def method_missing(name, *_args)
          fail "Unknown option #{name.to_s.gsub!('=', '')}"
        end

        ##
        # Tolerance Attribute with nil guard
        #
        # @return [Fixnum] tolerance
        #
        def tolerance
          @tolerance || 1000
        end

        ##
        # Secret Attribute with nil guard
        #
        # @return [String] secret
        #
        def secret
          @secret || ''
        end

        ##
        # Signature Attribute with nil guard
        #
        # @return [String] signature
        #
        def signature
          @signature || ''
        end
      end
    end
  end
end
