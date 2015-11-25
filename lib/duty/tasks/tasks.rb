module Duty
  module Commands
    module Git
    end
  end
end

module Duty
  module Tasks
    class StartFeature < Base
      include Duty::Commands::Git
    end
  end
end
