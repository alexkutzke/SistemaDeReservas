# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Role.delete_all
User.delete_all
# Discipline.delete_all
# Classroom.delete_all
=begin
Role.delete_all
Permission.delete_all
Discipline.delete_all
Classroom.delete_all
=end
p1 = Role.create(name: "Admin")

Permission.create(role_id: p1.id, session: 0, index: true, new: true, edit: true, remove: true)
Permission.create(role_id: p1.id, session: 1, index: true, new: true, edit: true, remove: true)
Permission.create(role_id: p1.id, session: 2, index: true, new: true, edit: true, remove: true)
Permission.create(role_id: p1.id, session: 3, index: true, new: true, edit: true, remove: true)
Permission.create(role_id: p1.id, session: 4, index: true, new: true, edit: true, remove: true)
Permission.create(role_id: p1.id, session: 5, index: true, new: true, edit: true, remove: true)
Permission.create(role_id: p1.id, session: 6, index: true, new: true, edit: true, remove: true)
Permission.create(role_id: p1.id, session: 7, index: true, new: true, edit: true, remove: true)
Permission.create(role_id: p1.id, session: 8, index: true, new: true, edit: true, remove: true)
Permission.create(role_id: p1.id, session: 9, index: true, new: true, edit: true, remove: true)
Permission.create(role_id: p1.id, session: 10, index: true, new: true, edit: true, remove: true)
Permission.create(role_id: p1.id, session: 11, index: true, new: true, edit: true, remove: true)
