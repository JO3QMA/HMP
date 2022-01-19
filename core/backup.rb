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
    @logger.info("\"#{source}\" を \"#{target}\" にコピーします。")
    FileUtils.cp_r(source, target)
  end

  def copy_zip(target)
    copy(File.join(@tmp, @filename), target)
  end

  def remove_history(target, keep = 7)
    if !keep.zero?
      Dir.glob(File.join(target, '*.zip')).each do |file|
        file_time = Date.parse(File.basename(file, '.zip').sub(/#{@name}/, ''))
        if Date.today - file_time > keep
          @logger.info("\"#{file}\" を削除します。")
          FileUtils.rm(file)
        end
      end
    else
      @logger.info('keepの値が0です。削除されません。')
    end
  end

  def create_tmp
    # 一時ディレクトリーを作成
    # @tmpには一時ディレクトリーのパスが格納される
    @tmp = Dir.mktmpdir(@name)
    @logger.info("一時ディレクトリー(\"#{@tmp}\")を作成しました。")
  end

  def copy_tmp(source, ignore = nil)
    # 一時ディレクトリーにコピー
    # @timestampにはコピーした日時を格納する。
    @timestamp = Time.now.strftime('%Y-%m-%d_%H-%M-%S')
    copy(source, File.join(@tmp, 'file'), ignore)
  end

  def remove_tmp
    # 一時ディレクトリーを削除
    @logger.info("一時ディレクトリー(\"#{@tmp}\")を削除します。")
    if Dir.exist?(@tmp) == true
      FileUtils.rm_r(@tmp)
    else
      @logger.info("\"#{@tmp}\" が存在しないためパスします。")
    end
  end

  def compress
    # ZIPに圧縮します。
    @filename = "#{@name}_#{@timestamp}.zip"
    source = File.join(@tmp, 'file')
    output = File.join(@tmp, @filename)
    @logger.info("\"#{source}\" を \"#{output}\" に圧縮します。")
    zip_file_generator = ZipFileGenerator.new(source, output)
    zip_file_generator.write
  end
end
