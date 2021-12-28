# frozen_string_literal: true

require 'yaml'

# 複数のYAMLを読むのでクラスにする
class Config
  attr_writer :path, :default_config
  attr_reader :name, :desc
  attr_reader :source, :tmp, :target, :time, :format, :keep

  def initialize
    @default = YAML.load_file(default_config)['default']
    set_default_value
    @yaml = YAML.load_file(path)
    set_value
  end

  def filename
    path.split('/').last
  end

  def set_default_value
    # デフォルト値を設定
    self.source = @default['source']
    self.tmp = @default['tmp']
    self.target = @default['target']
    self.time = @default['time']
    self.format = @default['format']
    self.keep = @default['keep']
  end

  def set_value
    # YAMLの設定値を設定
    self.name = @yaml['name']
    self.desc = @yaml['description']

    # 設定値なない場合デフォルト値を使う
    self.source = @yaml['backup']['source'] unless @yaml['backup']['source'].nil?
    self.tmp    = @yaml['backup']['tmp']    unless @yaml['backup']['tmp'].nil?
    self.target = @yaml['backup']['target'] unless @yaml['backup']['target'].nil?
    self.time   = @yaml['backup']['time']   unless @yaml['backup']['time'].nil?
    self.format = @yaml['backup']['format'] unless @yaml['backup']['format'].nil?
    self.keep   = @yaml['backup']['keep']   unless @yaml['backup']['keep'].nil?
  end

end
