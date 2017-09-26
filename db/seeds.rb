# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Perfil.delete_all
Action.delete_all

p1 = Perfil.create(name: "admin")
p2 = Perfil.create(name: "Admin Coordenação Acadêmica")
p3 = Perfil.create(name: "Admin Direção")

Action.create(perfil_id: p1.id, session: 0, view: false, register: false, edit: false, remove: false)
Action.create(perfil_id: p1.id, session: 2, view: true, register: true, edit: true, remove: true)
Action.create(perfil_id: p1.id, session: 4, view: true, register: true, edit: true, remove: true)
Action.create(perfil_id: p1.id, session: 5, view: true, register: true, edit: true, remove: true)
Action.create(perfil_id: p1.id, session: 6, view: true, register: true, edit: true, remove: true)
Action.create(perfil_id: p1.id, session: 7, view: true, register: true, edit: true, remove: true)
Action.create(perfil_id: p1.id, session: 8, view: true, register: true, edit: true, remove: true)
Action.create(perfil_id: p1.id, session: 9, view: true, register: true, edit: true, remove: true)
Action.create(perfil_id: p1.id, session: 10, view: true, register: true, edit: true, remove: true)

Action.create(perfil_id: p2.id, session: 4, view: true, register: false, edit: false, remove: false)
