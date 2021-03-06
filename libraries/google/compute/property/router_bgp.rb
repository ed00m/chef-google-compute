# Copyright 2018 Google Inc.
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

module Google
  module Compute
    module Data
      # A class to manage data for Bgp for router.
      class RouterBgp
        include Comparable

        attr_reader :asn
        attr_reader :advertise_mode
        attr_reader :advertised_groups
        attr_reader :advertised_ip_ranges

        def to_json(_arg = nil)
          {
            'asn' => asn,
            'advertiseMode' => advertise_mode,
            'advertisedGroups' => advertised_groups,
            'advertisedIpRanges' => advertised_ip_ranges
          }.reject { |_k, v| v.nil? }.to_json
        end

        def to_s
          {
            asn: asn.to_s,
            advertise_mode: advertise_mode.to_s,
            advertised_groups: advertised_groups.to_s,
            advertised_ip_ranges: ['[',
                                   advertised_ip_ranges.map(&:to_json).join(', '),
                                   ']'].join(' ')
          }.map { |k, v| "#{k}: #{v}" }.join(', ')
        end

        def ==(other)
          return false unless other.is_a? RouterBgp
          compare_fields(other).each do |compare|
            next if compare[:self].nil? || compare[:other].nil?
            return false if compare[:self] != compare[:other]
          end
          true
        end

        def <=>(other)
          return false unless other.is_a? RouterBgp
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
            { self: asn, other: other.asn },
            { self: advertise_mode, other: other.advertise_mode },
            { self: advertised_groups, other: other.advertised_groups },
            { self: advertised_ip_ranges, other: other.advertised_ip_ranges }
          ]
        end
      end

      # Manages a RouterBgp nested object
      # Data is coming from the GCP API
      class RouterBgpApi < RouterBgp
        def initialize(args)
          @asn = Google::Compute::Property::Integer.api_parse(args['asn'])
          @advertise_mode =
            Google::Compute::Property::AdvertiseModeEnum.api_parse(args['advertiseMode'])
          @advertised_groups =
            Google::Compute::Property::StringArray.api_parse(args['advertisedGroups'])
          @advertised_ip_ranges =
            Google::Compute::Property::RouterAdvertisedIpRangesArray.api_parse(
              args['advertisedIpRanges']
            )
        end
      end

      # Manages a RouterBgp nested object
      # Data is coming from the Chef catalog
      class RouterBgpCatalog < RouterBgp
        def initialize(args)
          @asn = Google::Compute::Property::Integer.catalog_parse(args[:asn])
          @advertise_mode =
            Google::Compute::Property::AdvertiseModeEnum.catalog_parse(args[:advertise_mode])
          @advertised_groups =
            Google::Compute::Property::StringArray.catalog_parse(args[:advertised_groups])
          @advertised_ip_ranges =
            Google::Compute::Property::RouterAdvertisedIpRangesArray.catalog_parse(
              args[:advertised_ip_ranges]
            )
        end
      end
    end

    module Property
      # A class to manage input to Bgp for router.
      class RouterBgp
        def self.coerce
          ->(x) { ::Google::Compute::Property::RouterBgp.catalog_parse(x) }
        end

        # Used for parsing Chef catalog
        def self.catalog_parse(value)
          return if value.nil?
          return value if value.is_a? Data::RouterBgp
          Data::RouterBgpCatalog.new(value)
        end

        # Used for parsing GCP API responses
        def self.api_parse(value)
          return if value.nil?
          return value if value.is_a? Data::RouterBgp
          Data::RouterBgpApi.new(value)
        end
      end
    end
  end
end
