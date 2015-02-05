# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
controller_dir = File.join Rails.root, 'app', 'controllers'
controller_path = Pathname.new controller_dir
Rails.application.config.assets.precompile += Dir[File.join controller_dir, '**', '*_controller.rb'].collect do |filename|
  File.join 'controllers', "#{(Pathname.new(filename).relative_path_from controller_path).to_s.chomp '_controller.rb'}.css"
end
Rails.application.config.assets.precompile += ['controllers/devise/registrations.css']
