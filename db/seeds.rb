# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Perfil.delete_all
Session.delete_all
Action.delete_all

Session.create(name: "Categorias")
Session.create(name: "Salas")
Session.create(name: "Departamentos")

Perfil.create(name: "admin")
Perfil.create(name: "Admin Coordenação Acadêmica")
Perfil.create(name: "Admin Direção")

Action.create(perfil_id: 1, session_id: 1, view: true, register: true, edit: true, remove: true)
Action.create(perfil_id: 1, session_id: 2, view: true, register: true, edit: true, remove: true)
Action.create(perfil_id: 1, session_id: 3, view: true, register: true, edit: true, remove: true)
