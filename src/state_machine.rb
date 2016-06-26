require_relative 'template'
require_relative 'state_holder'
require_relative 'errors'

module StateMachine
  def self.included(o)
    o.extend(Template)
    o.send :prepend, Template
  end
end
