include_files_data = {}
Dir.foreach(includes_dir) do |file|
  next if file == '.' || file == '..'
  file_path = File.join(includes_dir, file)
  
  if File.file?(file_path)
    last_modified = File.mtime(file_path).strftime("%Y-%m-%d %H:%M:%S")
    include_files_data[file] = { 'last_modified' => last_modified }
  end
end