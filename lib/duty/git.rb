require 'duty'

module Duty
  module Git
    def self.tasks
      [
        Tasks::StartFeature
      ]
    end

    module Tasks
      class BaseTask < ::Duty::Tasks::Base
      end

      class StartFeature < BaseTask
      end
    end
  end
end

Duty::Git
