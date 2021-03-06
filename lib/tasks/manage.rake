namespace :manager do

  task :add_role => [:environment] do
    raise "User email should be specified!" if ENV['email'].nil?
    raise "Role should be specified!" if ENV['role'].nil?

    user_email = ENV['email'].strip.downcase
    user_role = ENV['role'].strip.downcase

    raise "Role should be 'admin' or 'reporter'" unless ["admin", "reporter"].include? user_role

    user_by_email = User.where(email: user_email)

    raise 'User not found!' if user_by_email.nil?
    
    user_by_email.first.role = Role.new(name: user_role)

    p "Done!"
  end

end
