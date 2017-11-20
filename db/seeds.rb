# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Role.delete_all
Category.delete_all
Permission.delete_all
Schedule.delete_all

Discipline.delete_all
Klass.delete_all
Classroom.delete_all

# # NO CASO DO SEPT
p1 = Role.create(id: 1, name: "Admin")
p2 = Role.create(id: 2, name: "Coordenação acadêmica")
p3 = Role.create(id: 3, name: "Professor")

# Sessions
# 0 - Schedules
# 1 - Solicitations
# 2 - Perfis
# 3 - Usuários
# 4 - Setor
# 5 - Departamento
# 6 - Categoria
# 7 - Sala
# 8 - Disciplina
# 9 - Turma
# 10 - Equipamento
# 11 - Periodo

# Permissions pro admin do sistema
Permission.create(role_id: p1.id, session: 0, index: true, new: true, edit: true, remove: true, import: true)
Permission.create(role_id: p1.id, session: 1, index: true, edit: true, remove: true)
Permission.create(role_id: p1.id, session: 2, index: true, new: true, edit: true, remove: true)
Permission.create(role_id: p1.id, session: 3, index: true, new: true, edit: true, remove: true, import: true)
Permission.create(role_id: p1.id, session: 4, index: true, new: true, edit: true, remove: true)
Permission.create(role_id: p1.id, session: 5, index: true, new: true, edit: true, remove: true)
Permission.create(role_id: p1.id, session: 6, index: true, new: true, edit: true, remove: true)
Permission.create(role_id: p1.id, session: 7, index: true, new: true, edit: true, remove: true, import: true)
Permission.create(role_id: p1.id, session: 8, index: true, new: true, edit: true, remove: true, import: true)
Permission.create(role_id: p1.id, session: 9, index: true, new: true, edit: true, remove: true, import: true)
Permission.create(role_id: p1.id, session: 10, index: true, new: true, edit: true, remove: true)
Permission.create(role_id: p1.id, session: 11, index: true, new: true, edit: true, remove: true)

# Permissions para Coordenação acadêmica
Permission.create(role_id: p2.id, session: 0, index: true, new: true, edit: true, remove: true, import: true)
Permission.create(role_id: p2.id, session: 1, index: true, edit: true, remove: true)
Permission.create(role_id: p2.id, session: 2, index: false, new: false, edit: false, remove: false)
Permission.create(role_id: p2.id, session: 3, index: true, new: true, edit: true, remove: true, import: true)
Permission.create(role_id: p2.id, session: 4, index: true, new: true, edit: true, remove: true)
Permission.create(role_id: p2.id, session: 5, index: true, new: true, edit: true, remove: true)
Permission.create(role_id: p2.id, session: 6, index: true, new: true, edit: true, remove: true)
Permission.create(role_id: p2.id, session: 7, index: true, new: true, edit: true, remove: true, import: true)
Permission.create(role_id: p2.id, session: 8, index: true, new: true, edit: true, remove: true, import: true)
Permission.create(role_id: p2.id, session: 9, index: true, new: true, edit: true, remove: true, import: true)
Permission.create(role_id: p2.id, session: 10, index: true, new: true, edit: true, remove: true)
Permission.create(role_id: p2.id, session: 11, index: true, new: true, edit: true, remove: true)

# Permission Professor
Permission.create(role_id: p3.id, session: 0, index: true, new: true, edit: true, remove: true, import: true)
Permission.create(role_id: p3.id, session: 1, index: false, edit: false, remove: false)
Permission.create(role_id: p3.id, session: 2, index: false, new: false, edit: false, remove: false)
Permission.create(role_id: p3.id, session: 3, index: true, new: false, edit: false, remove: false, import: false)
Permission.create(role_id: p3.id, session: 4, index: false, new: false, edit: false, remove: false)
Permission.create(role_id: p3.id, session: 5, index: false, new: false, edit: false, remove: false)
Permission.create(role_id: p3.id, session: 6, index: false, new: false, edit: false, remove: false)
Permission.create(role_id: p3.id, session: 7, index: true, new: false, edit: false, remove: false, import: false)
Permission.create(role_id: p3.id, session: 8, index: true, new: false, edit: false, remove: false, import: false)
Permission.create(role_id: p3.id, session: 9, index: true, new: false, edit: false, remove: false, import: false)
Permission.create(role_id: p3.id, session: 10, index: false, new: false, edit: false, remove: false)
Permission.create(role_id: p3.id, session: 11, index: false, new: false, edit: false, remove: false)

@c1 = Category.create(id: 1, name: 'Sala de aula')
@c2 = Category.create(id: 2, name: 'Laboratório de Informática')

@cr1 = Classroom.create(id: 1, room: "A01", building: "A", state: true, capacity: 30, category_id: @c1.id);
@cr2 = Classroom.create(id: 2, room: "A16", building: "A", state: true, capacity: 40, category_id: @c2.id);
@cr3 = Classroom.create(id: 3, room: "A14", building: "A", state: false, capacity: 40, category_id: @c2.id);
#
# Schedule.create(title: "Festa da Ana", start: "2017-10-26 14:00:00", end: "2017-10-26 14:30:00", classroom_id: @cr1.id, user_id: 1);
# Schedule.create(title: "Churras", start: "2017-10-31 14:00:00", end: "2017-10-31 14:30:00", classroom_id: @cr1.id, user_id: 1);
# Schedule.create(title: "Festa do João", start: "2017-11-07 19:00:00", end: "2017-11-08 23:00:00", classroom_id: @cr2.id, user_id: 1);
