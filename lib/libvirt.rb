#
# libvirt.rb: main module for the ruby-libvirt bindings
#
# Copyright (C) 2007 Red Hat, Inc.
#
# Distributed under the GNU Lesser General Public License v2.1 or later.
# See COPYING for details
#
# David Lutterkort <dlutter@redhat.com>

require '_libvirt'

module Libvirt

    # A version in Libvirt's representation
    class Version
        attr_reader :version, :type

        def initialize(type, version)
            @type = type
            @version = version
        end

        def major
            version / 1000000
        end

        def minor
            version % 1000000 / 1000
        end

        def release
            version % 1000
        end

        def to_s
            "#{major}.#{minor}.#{release}"
        end
    end

    class Domain
      def state_s
        s=self.state
        s[0] # state
        s[1] # reason
        res=[]
        res[0] = case s[0]
        when 0
          'no state'
        when 1
          'the domain is running'
        when 2
          'the domain is blocked on resource'
        when 3
          'the domain is paused by user'
        when 4
          'the domain is being shut down'
        when 5
          'the domain is shut off'
        when 6
          'the domain is crashed'
        when 7
          'the domain is suspended by guest power management'
        when 8
          'NB: this enum value will increase over time as new events are added to the libvirt API. It reflects the last state supported by this version of the libvirt API.'
        end
      end
    end
end
