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
  end 
end


