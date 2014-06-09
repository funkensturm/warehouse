actions :delegate_to_package

attribute :name, kind_of: String, name_attribute: true

# Defining default action
def initialize(*args)
  super
  @action = :delegate_to_package
end
