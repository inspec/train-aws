# Connection definition file for an example Train plugin.

# Most of the work of a Train plugin happens in this file.
# Connections derive from Train::Plugins::Transport::BaseConnection,
# and provide a variety of services.  Later generations of the plugin
# API will likely separate out these responsibilities, but for now,
# some of the responsibilities include:
# * authentication to the target
# * platform / release /family detection
# * caching
# * API execution
# * marshalling to / from JSON
# You don't have to worry about most of this.

# Push platform detection out to a mixin, as it tends
# to develop at a different cadence than the rest
require 'train-aws/platform'

module TrainPlugins
  module Aws
    # You must inherit from BaseConnection.
    class Connection < Train::Plugins::Transport::BaseConnection
      # We've placed platform detection in a separate module; pull it in here.
      include TrainPlugins::Aws::Platform

      def initialize(options)
        # 'options' here is a hash, Symbol-keyed,
        # of what Train.target_config decided to do with the URI that it was
        # passed by `inspec -t` (or however the application gathered target information)
        # Some plugins might use this moment to capture credentials from the URI,
        # and the configure an underlying SDK accordingly.
        # You might also take a moment to manipulate the options.
        # Have a look at the Local, SSH, and AWS transports for ideas about what
        # you can do with the options.

        # Regardless, let the BaseConnection have a chance to configure itself.
        super(options)

        # If you need to attempt a connection to a remote system, or verify your
        # credentials, now is a good time.
      end

    end
  end
end
