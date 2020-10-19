require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'When I visit /students' do
    it 'should see a list of students and the number of professors they have' do
      snape = Professor.create(name: 'Severus Snape', age: 45, specialty: 'Potions')
      hagarid = Professor.create(name: 'Rubeus Hagrid', age: 38, specialty: 'Care of Magical Creatures')
      lupin = Professor.create(name: 'Remus Lupin', age: 49, specialty: 'Defense Against The Dark Arts')

      harry = Student.create(name: 'Harry Potter', age: 11, house: 'Gryffindor')
      malfoy = Student.create(name: 'Draco Malfoy', age: 12, house: 'Slytherin')
      longbottom = Student.create(name: 'Neville Longbottom', age: 11, house: 'Gryffindor')

      ProfessorStudent.create(student_id: harry.id, professor_id: snape.id)
      ProfessorStudent.create(student_id: harry.id, professor_id: hagarid.id)
      ProfessorStudent.create(student_id: harry.id, professor_id: lupin.id)
      ProfessorStudent.create(student_id: malfoy.id, professor_id: hagarid.id)
      ProfessorStudent.create(student_id: malfoy.id, professor_id: lupin.id)
      ProfessorStudent.create(student_id: longbottom.id, professor_id: snape.id)

      visit '/students'

      expect(page).to have_content("#{harry.name}: #{harry.num_professors}")
      expect(page).to have_content("#{malfoy.name}: #{malfoy.num_professors}")
      expect(page).to have_content("#{longbottom.name}: #{longbottom.num_professors}")
    end

    it 'lists students alphabetically' do
      snape = Professor.create(name: 'Severus Snape', age: 45, specialty: 'Potions')
      hagarid = Professor.create(name: 'Rubeus Hagrid', age: 38, specialty: 'Care of Magical Creatures')
      lupin = Professor.create(name: 'Remus Lupin', age: 49, specialty: 'Defense Against The Dark Arts')

      harry = Student.create(name: 'Harry Potter', age: 11, house: 'Gryffindor')
      malfoy = Student.create(name: 'Draco Malfoy', age: 12, house: 'Slytherin')
      longbottom = Student.create(name: 'Neville Longbottom', age: 11, house: 'Gryffindor')

      ProfessorStudent.create(student_id: harry.id, professor_id: snape.id)
      ProfessorStudent.create(student_id: harry.id, professor_id: hagarid.id)
      ProfessorStudent.create(student_id: harry.id, professor_id: lupin.id)
      ProfessorStudent.create(student_id: malfoy.id, professor_id: hagarid.id)
      ProfessorStudent.create(student_id: malfoy.id, professor_id: lupin.id)
      ProfessorStudent.create(student_id: longbottom.id, professor_id: snape.id)

      visit '/students'

      within all('.student')[0] do
        expect(page).to have_content(malfoy.name)
      end

      within all('.student')[1] do
        expect(page).to have_content(harry.name)
      end

      within all('.student')[2] do
        expect(page).to have_content(longbottom.name)
      end
    end
  end
end
