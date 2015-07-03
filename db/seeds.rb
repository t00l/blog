User.destroy_all
Post.destroy_all
Comment.destroy_all

posts = []
comments = []

users = User.create([
  {
    name: 'Moises Donoso Salinas',
    email: 'moisesdonoso@gmail.com',
    password: 'password',
    password_confirmation: 'password',
    role: 1
  },
  {
    name: 'Ignacio Donoso Salinas',
    email: 'ignaciodonoso@gmail.com',
    password: 'password',
    password_confirmation: 'password',
    role: 0
  },
  {
    name: 'Cristina Salinas Vega',
    email: 'cris@gmail.com',
    password: 'password',
    password_confirmation: 'password',
    role: 0
  }
])

900.times do
 posts << Post.create(titulo: Faker::Lorem.sentence(3, true, 4),
                      content: Faker::Lorem.paragraph(20, true, 10),
                      user: users.sample)
end

800.times do
  comments << Comment.create(comment: Faker::Lorem.paragraph(2),
                             post: posts.sample,
                             user: users.sample)
end