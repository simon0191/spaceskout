admin = Admin.new(email: "admin@example.com", password: 'password', password_confirmation: 'password')
admin.skip_confirmation!
admin.save!

space_owner = SpaceOwner.new(email: "owner@example.com", password: 'password', password_confirmation: 'password')
space_owner.skip_confirmation!
space_owner.save!

customer = Customer.new(email: "customer@example.com", password: 'password', password_confirmation: 'password')
customer.skip_confirmation!
customer.save!