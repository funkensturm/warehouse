actions :configure

attribute :home,  kind_of: String, name_attribute: true
attribute :owner, kind_of: String
attribute :group, kind_of: String

# Defining default action
def initialize(*args)
  super
  @action = :configure
end
