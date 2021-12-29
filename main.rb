# frozen_string_literal: true

require 'yaml'
require_relative './core/config'
require_relative './core/backup'
require_relative './core/logger'

# ヒト・モニュメント計画
class HMP
  def initialize(path = './config.yml')
    # デフォルト設定の読み込み
    logger = SingletonLogger.instance
    logger.info('初期化開始')
    @config = YAML.load_file(path)
    @config_array = []
  end

  def load_subconfig(path); end

  def get_config_array(path = './config')
    Dir.glob(File.join("#{path}/*.yml")).each do |file|
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
