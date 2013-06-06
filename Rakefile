task "test_message.pb.rb" do
  sh "bundle exec rprotoc test_message.proto --ruby_out ."
end

task :test => "test_message.pb.rb" do
  sh "ruby test.rb"
end
