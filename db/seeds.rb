# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Role.delete_all
Category.delete_all
Classroom.delete_all
Permission.delete_all
Event.delete_all
Schedule.delete_all

p1 = Role.create(name: "Admin")

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

@category = Category.create(name: 'Sala de aula')
@classroom = Classroom.create(room: "A01", building: "A", state: true, capacity: 30, category_id: @category.id);

Schedule.create(title: "Festa da Ana", start: "2017-10-26 14:00:00", end: "2017-10-26 14:30:00", classroom_id: @classroom.id, user_id: 1);
