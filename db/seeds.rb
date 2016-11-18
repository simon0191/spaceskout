User.roles.keys.each do |role|
  u = User.new(email: "#{role}@example.com", role: role, password: 'password', password_confirmation: 'password')
  u.skip_confirmation!
  u.save
end