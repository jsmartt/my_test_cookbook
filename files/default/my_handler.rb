require 'chef/handler'
require 'pry'

class Chef
  class Handler
    class MyHandler < ::Chef::Handler
      def initialize(args = {})
        @args = args
        # Code goes here
        # binding.pry
      end

      def report # This method must be implemented
        # Code goes here
        # binding.pry
      end
    end
  end
end
