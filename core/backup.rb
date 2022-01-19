# frozen_string_literal: true

require 'fileutils'
require 'tmpdir'
require_relative './zip'

# バックアップ処理
class Backup
  def initialize(name)
    # 初期化
    @logger = SingletonLogger.instance
    @name = name
  end

  def copy(source, target, _ignore = nil)
    @logger.info("#{source}を#{target}にコピーします。")
    FileUtils.cp_r(source, target)
  end

  def remove(target, _keep = 7)
    FileUtils.rm_r(target)
  end

  def create_tmp
    # 一時ディレクトリーを作成
    # @tmpには一時ディレクトリーのパスが格納される
    @tmp = Dir.mktmpdir(@name)
    @logger.info("一時ディレクトリーを作成しました。#{@tmp}")
  end

  def copy_tmp(source, ignore = nil)
    # 一時ディレクトリーにコピー
    # @timestampにはコピーした日時を格納する。
    @timestamp = Time.now.strftime('%Y-%m-%d_%H-%M-%S')
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

  def compress(target)
    @filename = "#{@name}_#{@timestamp}.zip"
    source = @tmp
    output = File.join(target, filename)
    @logger.info("FileName: #{@filename}, Output: #{output}")
    @logger.info("#{source}を#{output}に圧縮します。")
    FileUtils.mkdir_p(target)
    zip_file_generator = ZipFileGenerator.new(source, output)
    zip_file_generator.write
  end

  def parser_rm_file(filename)
    
  end
end
