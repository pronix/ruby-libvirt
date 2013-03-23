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
        res=[]
        case s[0]
        when 0
          res[0]='no state'
        when 1
          res[0]='the domain is running'
          reason={
            0=>'VIR_DOMAIN_RUNNING_UNKNOWN  ',
            1=>'normal startup from boot',
            2=>'migrated from another host',
            3=>'restored from a state file',
            4=>'restored from snapshot',
            5=>'returned from paused state',
            6=>'returned from migration',
            7=>'returned from failed save process',
            8=>'returned from pmsuspended due to wakeup event',
            9=>'VIR_DOMAIN_RUNNING_LAST'}
        when 2
          res[0]='the domain is blocked on resource'
          reason = {
            0 => 'VIR_DOMAIN_BLOCKED_UNKNOWN',
            1 => 'VIR_DOMAIN_BLOCKED_LAST'}
        when 3
          res[0]='the domain is paused by user'
          reason={
            0=>'the reason is unknown',
            1=>'paused on user request',
            2=>'paused for offline migration',
            3=>'paused for save',
            4=>'paused for offline core dump',
            5=>'paused due to a disk I/O error',
            6=>'paused due to a watchdog event',
            7=>'paused after restoring from snapshot',
            8=>'paused during shutdown process',
            9=>'paused while creating a snapshot'}
        when 4
          res[0]='the domain is being shut down'
          reason ={
            0 => 'VIR_DOMAIN_SHUTDOWN_UNKNOWN',
            1 => 'shutting down on user request',
            2 => 'VIR_DOMAIN_SHUTDOWN_LAST'}
        when 5
          res[0]='the domain is shut off'
        when 6
          res[0]='the domain is crashed'
          reason={0=>'VIR_DOMAIN_CRASHED_UNKNOWN',1=>'VIR_DOMAIN_CRASHED_LAST'}
        when 7
          res[0]='the domain is suspended by guest power management'
        when 8
          res[0]='NB: this enum value will increase over time as new events are added to the libvirt API. It reflects the last state supported by this version of the libvirt API.'
        end
          res[1]=reason[s[1]]
          return res
      end
    end
end
