require 'rails_helper'

feature 'restaurants' do
  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants to see here'
      expect(page).to have_link 'Add Restaurant'
    end
  end

  context 'restaurants have been added' do
    before do
      Restaurant.create(name: 'Pizza Hut')
    end

    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content 'Pizza Hut'
      expect(page).not_to have_content 'No restaurants to see here'
    end
  end

  context 'creating restaurants' do
    scenario 'user fills out form, which displays new restaurant' do
      visit '/restaurants'
      click_link 'Add Restaurant'
      fill_in 'Name', with: 'Pizza Hut'
      click_button 'Create Restaurant'
      expect(page).to have_content 'Pizza Hut'
      expect(current_path).to eq '/restaurants'
    end
  end

  context 'viewing a restaurant' do

    let!(:kfc) {Restaurant.create(name: 'KFC')}

    scenario 'lets a user view a restaurant' do
       visit '/restaurants'
       click_link 'KFC'
       expect(page).to have_content 'KFC'
       expect(current_path).to eq "/restaurants/#{kfc.id}"
    end
  end

  context 'editing restaurants' do

    before {Restaurant.create name: 'KFC'}

    scenario 'let a user edit a restaurant' do
       visit '/restaurants'
       click_link 'Edit'
       fill_in 'Name', with: 'Kentucky Fried Chicken'
       click_button 'Update Restaurant'
       expect(page).to have_content 'Kentucky Fried Chicken'
       expect(current_path).to eq '/restaurants'
    end
  end

  context 'deleting a restaurant' do

    before {Restaurant.create name: 'KFC'}

    scenario 'removes a restaurant when a user clicks a delete link' do
      visit '/restaurants'
      click_link 'Delete KFC'
      expect(page).to have_content 'KFC deleted successfully'
    end
  end
end
