actions :create

attribute :name,  kind_of: String, name_attribute: true
attribute :home,  kind_of: String
attribute :group, kind_of: String

# Defining default action
def initialize(*args)
  super
  @action = :create
end
