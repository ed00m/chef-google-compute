# Copyright 2017 Google Inc.
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# ----------------------------------------------------------------------------
#
#     ***     AUTO GENERATED CODE    ***    AUTO GENERATED CODE     ***
#
# ----------------------------------------------------------------------------
#
#     This file is automatically generated by Magic Modules and manual
#     changes will be clobbered when the file is regenerated.
#
#     Please read more about how to change this file in README.md and
#     CONTRIBUTING.md located at the root of this package.
#
# ----------------------------------------------------------------------------

require 'google/compute/property/array'
module Google
  module Compute
    module Data
      # A class to manage data for allowed for firewall.
      class FirewallAllowed
        include Comparable

        attr_reader :ip_protocol
        attr_reader :ports

        def to_json(_arg = nil)
          {
            'IPProtocol' => ip_protocol,
            'ports' => ports
          }.reject { |_k, v| v.nil? }.to_json
        end

        def to_s
          {
            ip_protocol: ip_protocol.to_s,
            ports: ports.to_s
          }.map { |k, v| "#{k}: #{v}" }.join(', ')
        end

        def ==(other)
          return false unless other.is_a? FirewallAllowed
          compare_fields(other).each do |compare|
            next if compare[:self].nil? || compare[:other].nil?
            return false if compare[:self] != compare[:other]
          end
          true
        end

        def <=>(other)
          return false unless other.is_a? FirewallAllowed
          compare_fields(other).each do |compare|
            next if compare[:self].nil? || compare[:other].nil?
            result = compare[:self] <=> compare[:other]
            return result unless result.zero?
          end
          0
        end

        def inspect
          to_json
        end

        private

        def compare_fields(other)
          [
            { self: ip_protocol, other: other.ip_protocol },
            { self: ports, other: other.ports }
          ]
        end
      end

      # Manages a FirewallAllowed nested object
      # Data is coming from the GCP API
      class FirewallAllowedApi < FirewallAllowed
        def initialize(args)
          @ip_protocol =
            Google::Compute::Property::String.api_parse(args['IPProtocol'])
          @ports =
            Google::Compute::Property::StringArray.api_parse(args['ports'])
        end
      end

      # Manages a FirewallAllowed nested object
      # Data is coming from the Chef catalog
      class FirewallAllowedCatalog < FirewallAllowed
        def initialize(args)
          @ip_protocol =
            Google::Compute::Property::String.catalog_parse(args[:ip_protocol])
          @ports =
            Google::Compute::Property::StringArray.catalog_parse(args[:ports])
        end
      end
    end

    module Property
      # A class to manage input to allowed for firewall.
      class FirewallAllowed
        def self.coerce
          lambda do |x|
            ::Google::Compute::Property::FirewallAllowed.catalog_parse(x)
          end
        end

        # Used for parsing Chef catalog
        def self.catalog_parse(value)
          return if value.nil?
          return value if value.is_a? Data::FirewallAllowed
          Data::FirewallAllowedCatalog.new(value)
        end

        # Used for parsing GCP API responses
        def self.api_parse(value)
          return if value.nil?
          return value if value.is_a? Data::FirewallAllowed
          Data::FirewallAllowedApi.new(value)
        end
      end

      # A Chef property that holds an integer
      class FirewallAllowedArray < Google::Compute::Property::Array
        def self.coerce
          lambda do |x|
            ::Google::Compute::Property::FirewallAllowedArray.catalog_parse(x)
          end
        end

        # Used for parsing Chef catalog
        def self.catalog_parse(value)
          return if value.nil?
          return FirewallAllowed.catalog_parse(value) \
            unless value.is_a?(::Array)
          value.map { |v| FirewallAllowed.catalog_parse(v) }
        end

        # Used for parsing GCP API responses
        def self.api_parse(value)
          return if value.nil?
          return FirewallAllowed.api_parse(value) \
            unless value.is_a?(::Array)
          value.map { |v| FirewallAllowed.api_parse(v) }
        end
      end
    end
  end
end
