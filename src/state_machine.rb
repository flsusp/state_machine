require_relative 'template'
require_relative 'event'
require_relative 'transition'
require_relative 'errors'

module StateMachine
  def self.included(o)
    o.extend(Template)
    o.send :prepend, Template
  end
end
