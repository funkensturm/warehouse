actions :install

attribute :name,                  kind_of: String, name_attribute: true
attribute :environment_variables, kind_of: Hash,   default: {}
attribute :domains,               kind_of: String, default: nil
attribute :passenger,             kind_of: [TrueClass, FalseClass], default: false
attribute :ssl,                   kind_of: [TrueClass, FalseClass], default: false
attribute :asset_pipeline,        kind_of: [TrueClass, FalseClass], default: false

# Defining default action
def initialize(*args)
  super
  @action = :install
end
