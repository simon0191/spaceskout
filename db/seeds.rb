admin = Admin.new(email: "admin@example.com", password: 'password', password_confirmation: 'password')
admin.skip_confirmation!
admin.save!

space_owner = SpaceOwner.new(email: "owner@example.com", password: 'password', password_confirmation: 'password')
space_owner.skip_confirmation!
space_owner.save!

customer = Customer.new(email: "customer@example.com", password: 'password', password_confirmation: 'password')
customer.skip_confirmation!
customer.save!

Category.new(name:"Professional", description: "(Meeting, Company Event or Team Building Event)", active: true).save
Category.new(name:"Social", description: "(Party, Dinner or Wedding)", active: true).save
Category.new(name:"Activity", description: "(Classes/Workshops, Team Building or Group Activities)", active: true).save


california = State.create!(name: 'California', active: true)

["Alameda","Antioch","Berkeley","Brentwood",
"Chico"	,"Citrus Heights","Clovis","Concord","Cupertino","Daly City","Davis",
"Elk Grove","Fairfield"	,"Folsom","Fresno",	"Fremont",	"Hanford"	,"Hayward"	,
"Livermore",	"Lodi","Madera"	,"Manteca"	,"Merced","Milpitas"	,"Modesto",
"Mountain View","Napa"	,"Novato"	,"Oakland"	,"Palo Alto"	,"Petaluma"	,"Pittsburg"	,
"Pleasanton"	,"Porterville"	,"Rancho Cordova"	,"Redding"	,"Redwood City",
"Richmond"	,"Rocklin"	,"Roseville"	,"Sacramento"	,"Salinas"	,"San Francisco"	,
"San Jose"	,"San Leandro","San Mateo","San Rafael"	,"San Ramon"	,"Santa Clara"	,"Santa Cruz"	,
"Santa Rosa","South San Francisco"	,"Stockton","Sunnyvale","Tracy","Tulare","Turlock","Union City","Vacaville"	,
"Vallejo"	,"Visalia"	,"Walnut Creek","Watsonville","Woodland","Yuba City"].each do |city|
  City.create!(name: city, state: california, active: true)
end