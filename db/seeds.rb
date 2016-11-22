admin = Admin.new(email: "admin@example.com", password: 'password', password_confirmation: 'password')
admin.skip_confirmation!
admin.save!

space_owner = SpaceOwner.new(
  email: "owner@example.com", password: 'password', password_confirmation: 'password',
  business_name: 'The Owners', first_name: 'John', last_name: 'Doe', phone: '12345678',
  remote_avatar_url: 'http://evmprint.be/wp-content/uploads/2014/08/team3.jpg'
)
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

Charity.create(
  name: "BOSS",
  description: "<p style=\"text-align:center\"><strong>The mission of Building Opportunities for Self-Sufficiency (BOSS) is to help homeless, poor, and disabled people achieve health and self-sufficiency. </strong></p><p>Founded in 1971, BOSS operates Housing, Health, Income, and Social Justice programs in the cities of Berkeley, Oakland, and Hayward that serve over 3,000 people a year, both families and single adults. The people BOSS works with are facing multiple challenges - from deep poverty, homelessness and former incarceration to mental illness, substance abuse, domestic violence and more. BOSS works with each person to help them understand the root cause of their situation and develop a goal plan for step by step progress towards achieving housing, income, stability and wellness.</p><br/><p>BOSS believes that every one of us, no matter what our situation or life experiences, can transform our lives and futures -- with the right kind of support and resources. </p><p>Learn more at <a href=\"www.self-sufficiency.org\">www.self-sufficiency.org!</a></p>",
  remote_logo_url: "https://s3-us-west-2.amazonaws.com/spaceskout/BOSS.Logo.040416.withtagline.WEB.jpg",
  featured: true
)