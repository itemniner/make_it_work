require "rails_helper"

RSpec.describe "on the index page" do 
  describe "as a visitor" do
    it "sees a list of the names of all the contestants" do
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

      recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
      furniture_challenge = Challenge.create(theme: "Apartment Furnishings", project_budget: 1000)

      project_1 = recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")
      project_2 = recycled_material_challenge.projects.create(name: "Boardfit", material: "Cardboard Boxes")

      project_3 = furniture_challenge.projects.create(name: "Upholstery Tuxedo", material: "Couch")
      project_4 = furniture_challenge.projects.create(name: "Litfit", material: "Lamp")

      ContestantProjects.create(contestant: ray, project: project_1)
      ContestantProjects.create(contestant: ray, project: project_2)
      ContestantProjects.create(contestant: alfredo, project: project_3)
      ContestantProjects.create(contestant: alfredo, project: project_4)

      visit "/contestants"

      within("#application-#{ray.id}") do
        expect(page).to have_content(ray.name)
        expect(page).to have_content(project_1.name)
        expect(page).to have_content(project_2.name)
      end

      within("#application-#{alfredo.id}") do
        expect(page).to have_content(alfredo.name)
        expect(page).to have_content(project_3.name)
        expect(page).to have_content(project_4.name)
      end
    end
  end
end



