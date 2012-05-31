# iTunes Version -- track.location doesnt work :/
# require 'rubygems'
# require 'fileutils'
# require 'rbosa'
# 
# playlists_name = ARGV.shift || "night"
# destination_path = ARGV.shift || destination_path
# FileUtils.mkdir_p(destination_path)
# 
# itunes = OSA.app('iTunes')
# playlist = itunes.sources.first.playlists.detect { |p| p.name == playlists_name }
# 
# playlist.tracks.each do |track|
#   song_path = track.location
#   song_file = File.basename(song_path)
#   puts "Copying #{song_path} to #{destination_path}"
#   system "cp", song_path, destination_path
# end

# CSV Version
require 'rubygems'
require 'fastercsv'
require 'fileutils'

playlist_path = ARGV.shift || raise(ArgumentError, "Must provide a playlist file")
destination_path = ARGV.shift || raise(ArgumentError, "Must provide a destination folder")
FileUtils.mkdir_p(destination_path)

FasterCSV.table(playlist_path, :col_sep => "\t").each do |row|
  song_path = File.join("/Volumes", *row.field(:location).split(":"))
  song_file = File.basename(song_path)
  puts "Copying #{song_path} to #{destination_path}"
  system "cp", song_path, destination_path
end