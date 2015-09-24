if ARGV[0] == 'help' or ARGV.empty?
	print <<-help
		first argument is directory with all the songs you want to convert to videos
		second argument is the image you want to put on the videos
		third argument is directory where videos will be saved
	help
else
	dir_with_songs = ARGV[0]
	image = ARGV[1]
	output_dir = ARGV[2]

	Dir[File.join(dir_with_songs, '*.mp3')].each do |s|
		song_name = File.basename s, '.mp3'
		`avconv -i "#{s}" -loop 1 -shortest -i "#{image}" -r 24 -acodec copy "#{File.join(output_dir, song_name)}.mkv"`
	end
end
