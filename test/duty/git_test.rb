require 'test_helper'

DUTY_MODULE = eval File.read(File.realpath('lib/duty/git.rb'))

class Duty::GitTest < Minitest::Spec
  it 'exposes all available tasks' do
    assert_tasks [
      Duty::Git::Tasks::StartFeature
    ]
  end

  private

  def assert_tasks(expected_tasks)
    assert_equal expected_tasks, actual_tasks

    actual_tasks.each do |task_class|
      assert task_class.ancestors.include?(::Duty::Tasks::Base)
    end
  end

  def actual_tasks
    DUTY_MODULE.tasks
  end
end
