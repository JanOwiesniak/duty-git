require 'duty'

module Duty
  module Git
    def self.namespace
      'git'
    end

    def self.tasks
      [
        Tasks::StartFeature,
        Tasks::ContinueFeature,
        Tasks::DeleteFeature,
        Tasks::MergeFeature,
        Tasks::Status
      ]
    end

    module Commands
      def checkout_master
        sh("Checkout `master` branch") { 'git checkout master' }
      end
    end

    module Tasks
      class BaseTask < ::Duty::Tasks::Base
      end

      class StartFeature < BaseTask
        include Duty::Git::Commands

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
          checkout_master
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
        include Duty::Git::Commands

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
          checkout_master
          sh("Delete `feature/#{@feature_name}` branch on `origin`") { "git push origin --delete remotes/origin/feature/#{@feature_name}" }
          sh("Delete `feature/#{@feature_name}` branch") { "git branch -d feature/#{@feature_name}" }
        end
      end

      class MergeFeature < BaseTask
        include Duty::Git::Commands

        def self.description
          "Merge a feature into `master`"
        end

        def self.usage
          "duty merge-feature <feature-name>"
        end

        def valid?
          @feature_name = @arguments.first
        end

        def execute
          checkout_master
          sh("Merge feature/#{@feature_name} into `master`") { "git merge --no-ff feature/#{@feature_name}" }
        end
      end

      class Status < BaseTask
        TAG_UNTRACKED = "[?]"
        TAG_DIRTY = "[ERR]"
        TAG_CLEAN = "[OK]"

        def self.description
          "Shows which directories are clean/dirty"
        end

        def self.usage
          "duty status"
        end

        def execute
          dirname = File.basename(Dir.pwd)

          status = `git status`.strip
          branch = `git rev-parse --abbrev-ref HEAD`.strip

          if status =~ /(Changes not staged|Untracked files)/
            files =
              if status =~ /Changes not staged/
                modified_files = status.scan(/modified:(.+)/).flatten.map(&:strip)
                modified_files.join(' ')
              else
                "<untracked files>"
              end

            if status =~ /Untracked files/ && status !~ /Changes not staged/
              sh("#{TAG_UNTRACKED} #{dirname.ljust(24)} #{branch} #{files}") {}
            else
              sh("#{TAG_DIRTY} #{dirname.ljust(24)} #{branch} #{files}") {}
            end
          else
            sh("#{TAG_CLEAN} #{dirname.ljust(24)} #{branch}") {}
          end
        end
      end
    end
  end
end

Duty::Registry.register(Duty::Git)
