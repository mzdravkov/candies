if ARGV[0] == 'help'
	print <<-help
		first argument is directory with all the songs you want to convert to videos
		second argument is the image you want to put on the videos
		third argument is directory where videos will be saved
    the fourth argument is the file extension of the songs. By default it is set to .mp3. (write the extension without point)
	help
else
	dir_with_songs = ARGV[0]
	image = ARGV[1]
	output_dir = ARGV[2]
  extension = ARGV[3] ? ARGV[3] : 'mp3'

	Dir[File.join(dir_with_songs, '*' + extension)].each do |s|
		song_name = File.basename(s, '.' + extension)
		`ffmpeg -i "#{s}" -loop 1 -shortest -i "#{image}" -r 24 -acodec copy "#{File.join(output_dir, song_name)}.mkv"`
	end
end
