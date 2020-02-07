require "rails_helper"

RSpec.describe "on the show page" do 
  describe "as a visitor" do
    it "can see that project's name and material" do
      recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
      project_1 = recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")

      visit "/projects/#{project_1.id }"

      expect(page).to have_content(project_1.name)
      expect(page).to have_content(project_1.material)
      expect(page).to have_content(project_1.challenge.theme)
    end
    it "can see the count of the number of contestants on this project" do
      ray = Contestant.create(
        name: "Ray",
        age: 37,
        hometown: "Anahiem",
        years_of_experience: 12)
      alfredo = Contestant.create(
        name: "Alfredo",
        age: 20,
        hometown: "Denver",
        years_of_experience: 3)
      alex = Contestant.create(
        name: "Alex",
        age: 13,
        hometown: "Richmond",
        years_of_experience: 8)

      recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)

      project_1 = recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")
      project_2 = recycled_material_challenge.projects.create(name: "Boardfit", material: "Cardboard Boxes")
      
      ContestantProject.create(contestant: ray, project: project_1)
      ContestantProject.create(contestant: alex, project: project_1)
      ContestantProject.create(contestant: alfredo, project: project_1)
      ContestantProject.create(contestant: alfredo, project: project_2)

      visit "/projects/#{project_1.id}"

      expect(project_1.contestant_count).to eq(3)
      expect(page).to have_content("Number of Contestants #{project_1.contestant_count}")
    end
    it "can see the average years of experence of the contestants that worked on that project" do
      ray = Contestant.create(
        name: "Ray",
        age: 25,
        hometown: "Anahiem",
        years_of_experience: 12)
      alfredo = Contestant.create(
        name: "Alfredo",
        age: 20,
        hometown: "Denver",
        years_of_experience: 3)
      alex = Contestant.create(
        name: "Alex",
        age: 15,
        hometown: "Richmond",
        years_of_experience: 8)

      recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)

      project_1 = recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")
      project_2 = recycled_material_challenge.projects.create(name: "Boardfit", material: "Cardboard Boxes")
      
      ContestantProject.create(contestant: ray, project: project_1)
      ContestantProject.create(contestant: alex, project: project_1)
      ContestantProject.create(contestant: alfredo, project: project_1)
      ContestantProject.create(contestant: alfredo, project: project_2)

      visit "/projects/#{project_1.id}"

      expect(project_1.average_age).to eq(20)
      expect(page).to have_content("Average age of Contestants #{project_1.average_age}")
    end
    it "can see a form a to add projects" do
      ray = Contestant.create(
        name: "Ray",
        age: 25,
        hometown: "Anahiem",
        years_of_experience: 12)
      alfredo = Contestant.create(
        name: "Alfredo",
        age: 20,
        hometown: "Denver",
        years_of_experience: 3)
      alex = Contestant.create(
        name: "Alex",
        age: 15,
        hometown: "Richmond",
        years_of_experience: 8)

      recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)

      project_1 = recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")
      project_2 = recycled_material_challenge.projects.create(name: "Boardfit", material: "Cardboard Boxes")
      
      ContestantProject.create(contestant: ray, project: project_1)
      ContestantProject.create(contestant: alex, project: project_1)
      ContestantProject.create(contestant: alfredo, project: project_1)
    
      visit "/projects/#{project_1.id}"

      expect(page).to have_content("Number of Contestants 3")
      
      fill_in :name, with: "Meg"
      fill_in :age, with: 22
      fill_in :hometown, with: "Hersey"
      fill_in :years_of_experience, with: 10

      click_on "Add Contestant To Project" 

      expect(current_path).to eq("/projects/#{project_1.id}")
      expect(page).to have_content("Number of Contestants 4")

      new_contestant = Contestant.last

      visit "/contestants"

      within("#contestant-#{new_contestant.id}") do
        expect(page).to have_content(new_contestant.name)
        expect(page).to have_content(project_1.name)
      end
    end
  end 
end

