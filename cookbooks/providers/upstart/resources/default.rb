actions :setup

attribute :name,                kind_of: String, name_attribute: true, required: true
attribute :logfile,             kind_of: String, required: true
attribute :command,             kind_of: String, required: true
attribute :user,                kind_of: String, default: 'root'
attribute :nice,                kind_of: Integer
attribute :envs,                kind_of: Hash,   default: {}
attribute :start_on,            kind_of: String, default: "[2345]"
attribute :stop_on,             kind_of: String, default: "[!2345]"
attribute :expect,              kind_of: String
attribute :pre_start,           kind_of: String
attribute :pre_stop,            kind_of: String
attribute :post_stop,           kind_of: String
attribute :autostart,           kind_of: [TrueClass, FalseClass], default: true
attribute :respawn,             kind_of: [TrueClass, FalseClass], default: true
attribute :high_nofile_limit,   kind_of: [TrueClass, FalseClass], default: false
attribute :memlock_unlimited,   kind_of: [TrueClass, FalseClass], default: false
attribute :load_envs_from_file, kind_of: [TrueClass, FalseClass], default: false
attribute :working_dir,         kind_of: String, default: nil
attribute :bash_profile,        kind_of: [TrueClass,FalseClass], default: false
attribute :kill_signal,         kind_of: String, default: 'SIGTERM'
attribute :kill_timeout,        kind_of: Integer, default: 5

# Defining default action
def initialize(*args)
  super
  @action = :setup
end
