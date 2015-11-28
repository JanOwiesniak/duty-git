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
        def self.description
          "Start a new feature"
        end

        def self.usage
          "duty start-feature <feature-name>"
        end

        def valid?
          @feature_name = @arguments.first
        end

        def execute
          sh("Checkout `master` branch") { 'git checkout master' }
        end
      end
    end
  end
end

Duty::Git
