# frozen_string_literal: true

require 'yaml'

# 複数のYAMLを読むのでクラスにする
class Config
  attr_writer :path, :default_config
  attr_reader :name, :desc, :source, :tmp, :target, :time, :format, :keep

  def initialize(path, default_config = './config.yml')
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
    @source = @default['source']
    @tmp = @default['tmp']
    @target = @default['target']
    @time = @default['time']
    @format = @default['format']
    @keep = @default['keep']
  end

  def set_value
    # YAMLの設定値を設定
    @name = @yaml['name']
    @desc = @yaml['description']
    @source = @yaml['backup']['source']

    # 設定値なない場合デフォルト値を使う
    @target = @yaml['backup']['target'] unless @yaml['backup']['target'].nil?
    @time   = @yaml['backup']['time']   unless @yaml['backup']['time'].nil?
    @format = @yaml['backup']['format'] unless @yaml['backup']['format'].nil?
    @keep   = @yaml['backup']['keep']   unless @yaml['backup']['keep'].nil?

    # targetがデフォルト値の場合、nameのディレクトリーを使う
    @target = File.join(@target, @name) if @target == @default['target']
  end

  def info
    ''
  end
end
