feature 'Companies' do
  scenario 'visit the empty index page' do
    visit companies_path
    expect(page).to have_content 'Companies'
  end

  scenario 'visit the index page with companies' do
    c1 = FactoryBot.create(:company)
    c2 = FactoryBot.create(:company)
    visit companies_path
    expect(page).to have_content c1.name
    expect(page).to have_content c2.name
  end

  scenario 'create a new company' do
    visit companies_path
    click_link 'New Company'
    expect(current_path).to eq(new_company_path)
    name = 'The Company GmbH'
    fill_in('Name', with: name)

    expect do
      click_button('Create Company')
    end.to change(Company, :count).from(0).to(1)

    expect(company = Company.first)
    expect(company.name).to eq(name)
    expect(current_path).to eq(company_path(company))
    expect(page).to have_content name
    expect(page).to have_content 'Company was successfully created.'
  end

  scenario 'show an existing company' do
    company = FactoryBot.create(:company)
    visit companies_path
    click_link 'Show'
    expect(current_path).to eq(company_path(company))
    expect(page).to have_content company.name

    click_link 'Back'
    expect(current_path).to eq(companies_path)
  end

  scenario 'edit an existing company' do
    company = FactoryBot.create(:company, name: 'Old Name')
    visit companies_path
    click_link 'Edit'
    expect(current_path).to eq(edit_company_path(company))
    new_name = 'New Name'
    fill_in('Name', with: new_name)

    expect do
      click_button('Update Company')
    end.to_not change(Company, :count)

    company.reload
    expect(company.name).to eq(new_name)
    expect(current_path).to eq(company_path(company))
    expect(page).to have_content new_name
    expect(page).to have_content 'Company was successfully updated.'
  end

  scenario 'links to the employees and back' do
    company = FactoryBot.create(:company)
    visit company_path(company)

    click_link 'List employees'
    expect(current_path).to eq(company_employees_path(company))

    click_link 'Back'
    expect(current_path).to eq(company_path(company))
  end

  # In a production app, I would figure out how to fix the WebDriverError and
  # document the fix in the README. I used capybara in a project a couple years
  # ago, but we found that the suite took simply too long to run. We replaced it
  # with more unit tests on the model level and request specs to cover the
  # controllers which run faster. I think having some system tests though can
  # be handy especially if the server is generating the html.
  # Normally, I wouldn't leave a failing spec like this in a project. They tend
  # to pile up and never be fixed if not fixed immediately.
  scenario 'delete an existing company with employees', js: true,
    skip: 'fails with WebDriverError on my machine. Wrote request spec instead' do
    _company = FactoryBot.create(:company, :with_employees,
                                 number_of_employees: 3)
    visit companies_path

    expect do
      expect do
        accept_confirm do
          click_link 'Destroy'
        end
      end.to change(Company, :count).from(1).to(0)
    end.to change(Employee, :count).from(3).to(0)

    expect(current_path).to eq(companies_path)
    expect(page).to have_content 'Company was successfully destroyed.'
  end
end
