namespace :update do
  task :video_position_adjust => :environment do
    Video.update_all position: nil
    puts "All the videos positions have been changed to nil!"
  end
end
