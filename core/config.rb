# frozen_string_literal: true

require 'yaml'

# 複数のYAMLを読むのでクラスにする
class Config
  attr_writer :path, :default_config
  attr_reader :source, :tmp, :target, :time

  def initialize
    @default = YAML.load_file(default_config)['default']
    set_default_value
    @yaml = YAML.load_file(path)
  end

  def filename
    path.split('/').last
  end

  def set_default_value
    self.source = @default['source']
    self.tmp = @default['tmp']
    self.target = @default['target']
    self.time = @default['time']
  end
end
