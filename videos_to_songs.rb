require 'shellwords'

if ARGV[0] == 'help' or ARGV.empty?
  print <<-help
    Converts mkv files to mp3s

    first argument is directory with all the videos you want to convert to songs
    second argument is directory where mp3s will be saved
  help
else
  dir_with_videos = ARGV[0]
  output_dir = ARGV[1]

	Dir[File.join(dir_with_videos, '*.mkv')].each do |v|
    video_name = File.basename(v, '.mkv')
    song_file = File.join(output_dir, video_name) + '.mp3'
    p video_name, song_file
    `ffmpeg -i #{v.shellescape} -vn -acodec copy #{song_file.shellescape}`
  end
end
