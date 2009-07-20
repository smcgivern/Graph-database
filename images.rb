SED = "sed -i -e 's/<svg.*/<svg width=\"100%\" height=\"100%\"/'"
PNG = 'rsvg-convert -a -h 400'
PNGS = 'rsvg-convert -a -h 25'
GLOB = ARGV[0] || '*'

Dir["dot/#{GLOB}.dot"].each do |file|
  base = file.split('/').last.split('.').first
  `neato -n -opublic/image/#{base}.svg -Tsvg #{file}`
  `#{SED} public/image/#{base}.svg`
  `#{PNG} -o public/image/#{base}.png public/image/#{base}.svg`
  `#{PNGS} -o public/image/small/#{base}.png public/image/#{base}.svg`
end
