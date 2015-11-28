require 'duty'

module Duty
  module Git
    def self.tasks
      [
        Tasks::StartFeature,
        Tasks::ContinueFeature,
        Tasks::DeleteFeature
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
          sh("Create `feature/#{@feature_name}` branch") { "git checkout -b feature/#{@feature_name}" }
          sh("Push `feature/#{@feature_name}` branch to `origin`") { "git push -u origin feature/#{@feature_name}" }
        end
      end

      class ContinueFeature < BaseTask
        def self.description
          "Continue on an already existing feature"
        end

        def self.usage
          "duty continue-feature <feature-name>"
        end

        def valid?
          @feature_name = @arguments.first
        end

        def execute
          sh("Checkout `feature/#{@feature_name}` branch") { "git checkout feature/#{@feature_name}" }
        end
      end

      class DeleteFeature < BaseTask
        def self.description
          "Delete a feature"
        end

        def self.usage
          "duty delete-feature <feature-name>"
        end

        def valid?
          @feature_name = @arguments.first
        end

        def execute
          sh("Checkout `master` branch") { 'git checkout master' }
          sh("Delete `feature/#{@feature_name}` branch on `origin`") { "git push origin --delete remotes/origin/feature/#{@feature_name}" }
          sh("Delete `feature/#{@feature_name}` branch") { "git branch -d feature/#{@feature_name}" }
        end
      end
    end
  end
end

Duty::Git
