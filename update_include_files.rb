require 'fileutils'
require 'time'

includes_dir = File.join(Dir.pwd, '_includes')
data_file = File.join(Dir.pwd, '_data', 'include_files.yml')

include_files_data = {}

Dir.foreach(includes_dir) do |file|
  next if file == '.' || file == '..'
  file_path = File.join(includes_dir, file)
  
  if File.file?(file_path)
    last_modified = File.mtime(file_path).strftime("%Y-%m-%d %H:%M:%S")
    include_files_data[file] = { 'last_modified' => last_modified }
    puts "Processed #{file}: Last modified #{last_modified}"
  end
end

File.open(data_file, 'w') do |f|
  require 'yaml'
  f.write(include_files_data.to_yaml)
end

puts "Updated #{data_file} with last modified dates."
