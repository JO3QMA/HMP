# frozen_string_literal: true

require 'yaml'
require_relative './core/config'
require_relative './core/backup'
require_relative './core/logger'

# ヒト・モニュメント計画
class HMP
  def initialize(path = './config.yml')
    # デフォルト設定の読み込み
    @logger = SingletonLogger.instance
    @logger.info('初期化開始')
    @config = YAML.load_file(path)
    @logger.info('初期化完了')
  end

  def get_config_array(path = './config')
    @logger.info('バックアップの設定ファイルの読み込み開始')
    file_array = []
    Dir.glob(File.join("#{path}/*.yml")).each do |file|
      file_array << file
    end
    @logger.info('バックアップの設定ファイルの読み込み完了')
    file_array.to_a
  end

  def run_backup(config_array)
    @logger.info('バックアップ処理開始')
    config_array.each do |config_path|
      @logger.info("=====#{config_path}=====")
      config = Config.new(config_path)
      backup = Backup.new(config.name)
      backup.create_tmp
      backup.copy_tmp(config.source)
      backup.compress(config.target)
      backup.remove_tmp
    end
    @logger.info('バックアップ処理完了')
  end

  def main
    @logger.info('メイン処理開始')
    config_array = get_config_array(@config['config_dir'])
    run_backup(config_array)
    puts config_array
  end
end

if __FILE__ == $PROGRAM_NAME
  hmp = HMP.new
  hmp.main
end
