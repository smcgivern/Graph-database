Dir['dot/*.dot'].each do |file|
  `./create-images #{file.split('/').last.split('.').first} #{file}`
end

`./create-sprites`
