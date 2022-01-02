# frozen_string_literal: true

require 'fileutils'
require 'tmpdir'
# require 'rubyzip'

# バックアップ処理
class Backup
  def initialize
    # 初期化
    @logger = SingletonLogger.instance
  end

  def copy(source, target, _ignore = nil)
    @logger.info("#{source}を#{target}にコピーします。")
    FileUtils.cp_r(source, target)
  end

  def remove(target, _keep = 7)
    FileUtils.rm_r(target)
  end

  def create_tmp(name)
    # 一時ディレクトリーを作成
    # @tmpには一時ディレクトリーのパスが格納される
    @tmp = Dir.mktmpdir(name)
    @logger.info("一時ディレクトリーを作成しました。#{@tmp}")
  end

  def copy_tmp(source, ignore = nil)
    # 一時ディレクトリーにコピー
    copy(source, @tmp, ignore)
  end

  def remove_tmp
    # 一時ディレクトリーを削除
    @logger.info("一時ディレクトリー(#{@tmp})を削除します。")
    if Dir.exist?(@tmp) == true
      remove(@tmp, 0)
    else
      @logger.info("#{@tmp}が存在しないためパスします。")
    end
  end

  def compress(target, format = 'zip')

  end
end
