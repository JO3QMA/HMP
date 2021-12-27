# frozen_string_literal: true

require 'yaml'
require './core/config'

# 人モニュメント計画
class HMP
  def initialize(_path = './config.yml')
    # デフォルト設定の読み込み
    @config = YAML.load_file('config.yml')
    @config_array = []
  end

  def load_subconfig(path); end

  def get_config_array(path = './config')
    Dir.glob(path + '/*.yml').each do |file|
      @config_array << YAML.load_file(file)
    end
  end

  def main
    @config_array = get_config_array(@config['config_dir'])
    puts @config_array
  end
end

if __FILE__ == $PROGRAM_NAME
  hmp = HMP.new
  hmp.main
end
