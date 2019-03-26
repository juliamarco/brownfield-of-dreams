namespace :update do
  # frozen_string_literal: true
  task video_position_adjust: :environment do
    Video.update_all position: nil
    puts 'All the videos positions have been changed to nil!'
  end
end
